require 'pry'

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

# Main
@project_directory = Dir.pwd
# Set working directory
Dir.chdir('markdown')

puts "directory: #{Dir.pwd}\n"  

# Get filenames to move
files = directory_filenames
puts files

files.each do |fname|
 lines = File.readlines(fname)
  puts "#{fname}: #{lines.count} lines"
  lines.each do |l|
    
    # Work with each line
    puts l
  end 
end
