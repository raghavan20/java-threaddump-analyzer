require 'rake'
require 'rake/testtask'

task :default => :test

task :test do
  Dir.glob('./tests/**/*test_*.rb').each { |file|
      #puts "running file: " << file 
      #puts `ruby #{file}`
      require file 
    }
end
