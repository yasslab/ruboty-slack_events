# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "bump/tasks"

Bump.changelog = true

RuboCop::RakeTask.new

task default: :rubocop
