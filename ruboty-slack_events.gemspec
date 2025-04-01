# frozen_string_literal: true

require_relative "lib/ruboty/slack_events/version"

Gem::Specification.new do |spec|
  spec.name = "ruboty-slack_events"
  spec.version = Ruboty::SlackEvents::VERSION
  spec.authors = ["Tomoya Chiba"]
  spec.email = ["tomo.asleep@gmail.com"]

  spec.summary = "Ruboty adapter with Slack Events API"
  spec.description = "Ruboty adapter with Slack Events API"
  spec.homepage = "https://github.com/tomoasleep/ruboty-slack_events"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tomoasleep/ruboty-slack_events"
  spec.metadata["changelog_uri"] = "https://github.com/tomoasleep/ruboty-slack_events/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "async-websocket", "~> 0.25"
  spec.add_dependency "ruboty", ">= 1.1.4"
  spec.add_dependency "slack-ruby-client", "~> 2.5"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
