require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end
