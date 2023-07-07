# frozen_string_literal: true

require_relative "lib/keal/version"

Gem::Specification.new do |spec|
  spec.name = "keal"
  spec.version = Keal::VERSION
  spec.authors = ["Rory Dudley"]
  spec.email = ["rory.dudley@gmail.com"]

  spec.summary = "Keep alive program for Linux/GNOME."
  spec.description = "Keep alive program for the GNOME desktop environment on Linux, inspired by caffeinate(8) on MacOS."
  spec.homepage = "https://github.com/pinecat/keal"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pinecat/keal"
  spec.metadata["changelog_uri"] = "https://github.com/pinecat/keal/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = %w[ext/gsettings/extconf.rb]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
