require 'pry'
require 'awesome_print'

# methods

def dash_filename(filename)
  filename.split.join('-')
end

def cleanup_filename(filename)
    if filename.include?(' ')
      bad_filename = @source_directory + '/' + filename + '.doc'
      good_filename = @source_directory + '/' + dash_filename(filename) + '.doc'
      FileUtils.mv bad_filename, good_filename 
    end
end

def directory_filenames()
  files = []
  Dir.entries('.').each do |f|
    # use just one file for now
    file_basename = File.basename(f)
    unless file_basename.include?('.pdf')
      case file_basename 
      when '.'
      when '..'
      else
        #fname = File.basename(f, '.doc').downcase
        files << file_basename.sub('.doc', '')
      end
    end
  end
  files
end

def get_and_set_source_directories
  # current directory
  @project_directory = Dir.pwd
  puts "Current directory: #{@project_directory}"

  # ask for desired directory to work with
  puts "which directory to work with? "
  @source_directory = gets.strip.chomp
  puts "Opening #{@source_directory}\n\n"

  # change to desired directory
  Dir.chdir(@source_directory)
  puts "Current directory: " 
  puts Dir.pwd
end

def convert_to_md(filename)
  @dashed_filename = dash_filename(filename) 
  
  md_file = dashed_filename + '.md'

  FileUtils.touch("#{md_file}")
  tmp = "w2m #{@source_directory}/#{dashed_filename}.doc"
  binding.pry 
  output = %x(tmp)
  puts output
end

# Main logic
get_and_set_source_directories

files = directory_filenames

Dir.chdir(@project_directory)
puts "\ncurrent directory: #{Dir.pwd}\n"

# Iterate over all files and directories in the current directory
files.each do |f|

  # remove white spaces from filenames if necessary
  cleanup_filename(f)

  # Test md transform on one file
  if f.downcase == "02 mystical"

    # convert file doc file to md
    convert_to_md(f)
  end
end
