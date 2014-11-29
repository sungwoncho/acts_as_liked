require 'rspec/core/rake_task'
require "bundler/gem_tasks"

desc "Run specs"
RSpec::Core::RakeTask.new(:spec)

desc "Default: run specs"
task default: :specrequire 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task default: :test
