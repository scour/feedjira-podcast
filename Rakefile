require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.pattern = "test/**/test_*.rb"
end

require "rubocop/rake_task"
RuboCop::RakeTask.new(:analyze)

task checks: [:test, :analyze]
task default: :test
