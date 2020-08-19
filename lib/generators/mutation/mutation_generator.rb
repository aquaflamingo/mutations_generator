# frozen_string_literal: true

require 'rails/generators/base'

class MutationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  argument :inputs, type: :array, default: [], banner: 'attribute[:filter][:required] attribute[:filter][:optional]'

  def create_mutation_file
    mutation_dir_path = 'app/mutations'
    generator_path = mutation_dir_path + "/#{file_name}.rb"

    Dir.mkdir(mutation_dir_path) unless File.exist?(mutation_dir_path)

    set_local_assigns!

    template 'mutation.erb', generator_path
  end

  def set_local_assigns!
    ins = inputs.clone
    attributes = ins.map { |i| GeneratedAttribute.parse(i) }
    @required = attributes.select(&:required)
    @optional = attributes.select(&:optional)
    @klass_name = file_name.camelize
  end

  class GeneratedAttribute
    FILTER_OPTIONS = %w[string integer model hash array boolean date duck input symbol time].freeze
    INPUT_OPTIONS = %w[required optional].freeze

    attr_accessor :name, :filter, :input

    class << self
      def parse(definition)
        name, filter, input_type = definition.split(':')
        raise 'name required' if name.nil?
        raise 'filter type required' if filter.nil?

        input_type ||= 'required'

        filter = validate_filter!(filter)
        input_type = validate_input_type!(input_type)
        name = name.to_sym

        new(name, filter, input_type)
      end

      def validate_input_type!(input_type)
        unless INPUT_OPTIONS.include?(filter)
          raise "invalid input type must be one of #{INPUT_OPTIONS}"
        end

        input_type
      end

      def validate_filter!(filter)
        unless FILTER_OPTIONS.include?(filter)
          raise "invalid filter type must be one of #{FILTER_FILTER_OPTIONS}"
        end

        filter
      end
    end

    def initialize(name, filter, input_type)
      @name = name
      @filter = filter || 'string'
      @input_type = input_type || 'required'
    end
  end
end
