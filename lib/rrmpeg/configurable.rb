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

      def _add(config)
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
        _add(var)
      end

      def flag(label, option:, default: false)
        flag = Flag.new(label, option: option, default: default)
        _add(flag)
      end

      def option(label, option:, default: nil)
        option = Option.new(label, option: option, default: default)
        _add(option)
      end

      def arg(label, default: nil)
        arg = Arg.new(label, default: default)
        _add(arg)
      end

      def group(label)
        group = Group.new(label)
        _add(group)
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

    class Flag
      attr_reader :label, :option, :default

      def initialize(label, option:, default: false)
        @label = label.to_sym
        @option = option
        @default = default
      end
    end

    class Option
      attr_reader :label, :option, :default

      def initialize(label, option:, default: nil)
        @label = label.to_sym
        @option = option
        @default = default
      end
    end

    class Arg
      attr_reader :label, :default

      def initialize(label, default: nil)
        @label = label.to_sym
        @default = default
      end
    end

    class Group
      attr_reader :label

      def initialize(label)
        @label = label
      end
    end
  end
end
