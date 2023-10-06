# frozen_string_literal: true

module RRmpeg
  module Configurable
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module InstanceMethods
      def ==(other)
        return false unless self.class == other.class

        true
      end

      def _configs
        @_configs ||= {}
      end

      def _get(label)
        if _configs.key?(label)
          _configs[label]&.value
        else
          _defaults[label]
        end
      end

      def _set(config, value)
        _configs[config.label] = ConfigValue.new(config: config, value: value)
      end

      def _defaults
        self.class._defaults
      end
    end

    module ClassMethods
      def _configs
        @_configs ||= {}
      end

      def _defaults
        _configs.each.with_object({}) do |(label, config), defaults|
          next if config.default.nil?

          defaults[label] = config.default
        end
      end

      def _define(config)
        _configs[config.label] = config

        define_method(config.label) do |*arg|
          arg.compact!
          if arg.empty?
            _get(config.label)
          else
            arg = arg.first if arg.size == 1
            _set(config, arg)
          end
        end
      end

      def var(label, default: nil)
        var = Var.new(label, default: default)

        _define(var)
      end
    end

    class ConfigValue
      attr_reader :config, :value

      def initialize(config:, value:)
        @config = config
        @value = value
      end
    end

    class Var
      attr_reader :label, :default

      def initialize(label, default: nil)
        @label = label.to_sym
        @default = default
      end
    end
  end
end
