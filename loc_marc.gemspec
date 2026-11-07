# frozen_string_literal: true

require_relative "lib/loc_marc/version"

Gem::Specification.new do |spec|
  spec.name = "loc_marc"
  spec.version = LocMarc::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com"]

  spec.summary       = "Library of Congress MARC 21 / MODS / MADS parser"
  spec.description   = "Library of Congress MARC 21 / MODS / MADS parser"
  spec.homepage      = "https://github.com/relaton/loc_marc"
  spec.license       = "BSD-2-Clause"

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
  spec.required_ruby_version = ">= 2.7.0"

  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "shale"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage
end
