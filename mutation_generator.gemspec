# frozen_string_literal: true

require_relative 'lib/mutation_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'mutation_generator'
  spec.version       = MutationGenerator::VERSION
  spec.authors       = ['robertsimoes']
  spec.email         = ['robertsimoes@users.noreply.github.com']

  spec.summary       = 'Extension for Ruby on Rails to add Mutation generators'
  spec.description   = 'Mutations are an elegant implementation of the Command and ServiceObject pattern in Ruby on Rails projects. This gem extends Rails generators to include a mutation generator.'
  spec.homepage      = 'https://github.com/robertsimoes'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/robertsimoes'
  spec.metadata['changelog_uri'] = spec.metadata['source_code_uri'] + '/releases'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'mutations', '~> 0.9.1'
  spec.add_development_dependency 'rails', '~>6.0.3.1'
end