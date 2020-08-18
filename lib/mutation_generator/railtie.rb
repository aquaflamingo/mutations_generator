# frozen_string_literal: true

module MutationGenerator
  def self.root
    File.dirname __dir__
  end

  class MutationGeneratorRailtie < Rails::Railtie
    mutation_generator_path = MutationGenerator.root.+'/mutation_generator/mutation/mutation_generator.rb'

    config.app_generators do
      require mutation_generator_path
    end
  end
end
