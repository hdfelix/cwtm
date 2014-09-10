require 'pry'
require 'awesome_print'
require 'word-to-markdown'

# methods

def dash_filename(filename)
  filename.split.join('-')
end

def cleanup_filename(filename)
    if filename.include?(' ')
      bad_filename = @source_directory + '/' + filename + '.doc'
      good_filename = @source_directory + '/' + dash_filename(filename) + '.doc'
      FileUtils.mv bad_filename, good_filename.downcase
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
  # puts "which directory to work with? "
  # @source_directory = gets.strip.chomp
  # puts "Opening #{@source_directory}\n\n"

  # change to desired directory
  @source_directory = '/Users/Hector/Desktop/84PreciousWords'
  Dir.chdir(@source_directory)
  puts "Current directory: " 
  puts Dir.pwd
end

def convert_to_md(filename)
  @dashed_filename = dash_filename(filename) 
  
  md_file = @dashed_filename + '.md'

  # remove the target md file if it exists
  #FileUtils.rm("#{md_file}")
  
  # create a new md file
  FileUtils.touch("#{md_file}")

  output = WordToMarkdown.new("#{@source_directory}/markdown/#{@dashed_filename}.doc")

  open(md_file, 'w') { |f|
    f.puts output
  }
  puts output

end

# Main logic
get_and_set_source_directories

files = directory_filenames

Dir.chdir(@project_directory)
puts "\ncurrent directory: #{Dir.pwd}\n"

# Iterate over all files and directories in the current directory
files.each do |f|
  binding.pry
  # remove white spaces from filenames if necessary
  cleanup_filename(f)

  # Test md transform on one file
  if f.downcase == "02-mystical"

    # convert file doc file to md
    convert_to_md(f)
  end
end

