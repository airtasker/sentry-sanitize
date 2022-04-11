require_relative 'lib/sentry/sanitize/version'

Gem::Specification.new do |spec|
  spec.name          = "sentry-sanitize"
  spec.version       = Sentry::Sanitize::VERSION
  spec.authors       = ["Niko Roberts"]
  spec.email         = ["niko@tasboa.com"]

  spec.summary       = "Client side sanitizer for Sentry"
  spec.description   = "Client side sanitizer for Sentry. Replicating the Raven sanitization from pre 4.0"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = "https://github.com/airtasker/sentry-sanitize/"
  spec.metadata["source_code_uri"] = "https://github.com/airtasker/sentry-sanitize/"
  spec.metadata["changelog_uri"] = "https://github.com/airtasker/sentry-sanitize/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
