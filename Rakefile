# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "bump/tasks"
require "rspec/core/rake_task"

Bump.changelog = true

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task default: %i[rubocop spec]
