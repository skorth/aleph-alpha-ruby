require_relative "lib/aleph-alpha/version"

Gem::Specification.new do |spec|
  spec.name          = "aleph-alpha-ruby"
  spec.version       = AlephAlpha::VERSION
  spec.authors       = ["Sascha Korth"]
  spec.email         = ["korth.sascha@gmail.com"]

  spec.summary       = "Aleph Alpha Ruby Client"
  spec.homepage      = "https://github.com/skorth/aleph-alpha-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/skorth/aleph-alpha-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/skorth/aleph-alpha-ruby/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

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

  spec.add_dependency "faraday", ">= 1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
