require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: ['install', :spec]

task :install do
  sh 'bundle install'
end

task :cop do
  sh 'rubocop'
end

task verify: [:default] do
end
