# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

task default: %i[standard test]

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :standard do
  exec "standardrb"
end
