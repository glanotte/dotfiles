require 'rake'

desc "install the dot files into user's home directory"
task :install do
  skip_files = %w[Rakefile README.md LICENSE Brewfile essential.vim]
  replace_all = false
  Dir['*'].each do |file|
    next if skip_files.include? file
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end
end

namespace :vim do
  desc "updates submodules"
  task :update do
    system "git submodule foreach git pull origin master"
  end

  desc "install submodule"
  task :install do
    repo_path = ENV['REPO']
    name = repo_path.split(/\//).last
    name = name.sub(/\.git$/, '')
    puts "adding submodule #{name} from #{repo_path}"
    system "git submodule add #{repo_path} vim/bundle/#{name}"
  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
