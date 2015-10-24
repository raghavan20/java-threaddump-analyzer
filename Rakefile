require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << %w(tests lib)
  task.pattern = 'tests/**/test_*.rb'
end

desc "Run tests"
task :default => :test