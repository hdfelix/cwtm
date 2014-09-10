require 'pry'

def directory_filenames()
  files = []
  Dir.entries('.').each do |f|
    # use just one file for now
    file_basename = File.basename(f)
    unless file_basename.include?('.rb')
      case file_basename 
      when '.'
      when '..'
      else
        #files << file_basename.sub('.md', '')
        files << file_basename
      end
    end
  end
  files
end

# Main 
@project_directory = Dir.pwd
target = '/Users/Hector/code/jekyll-test/_drafts'
# Set working directory
Dir.chdir('markdown')

puts "directory: #{Dir.pwd}\n"  

# Get filenames to move
files = directory_filenames

# Loop through files array
files.each do |f|
  puts "  #{File.basename(f)}"
  binding.pry
  FileUtils.cp f, target
end

print "\nCopyied #{files.count} file(s).\n\n"

