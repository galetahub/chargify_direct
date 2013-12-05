require 'bundler/gem_tasks'
require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test" << "test/chargify_direct"
  t.test_files = FileList['test/*_test.rb', 'test/chargify_direct/*_test.rb']
  t.verbose = true
end

task :default => :test
