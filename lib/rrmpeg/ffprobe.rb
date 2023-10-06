# frozen_string_literal: true

require_relative 'ffprobe_config'

module RRmpeg
  class FFprobe
    def config
      @config ||= self.class.new_config
    end

    def ffprobe_cmd(*args, ffprobe_bin: ffprobe_config.bin, **opts)
      # puts "ffprobe_cmd> #{ffprobe_bin}, #{args}"
      probe_output, status = Open3.capture2(ffprobe_bin, *args, **opts)
      raise RRmpeg::Error, "#{ffprobe_bin} fails on args: #{args}, opts: #{opts}" if status != 0

      probe_output
    end

    def ffprobe(config: ffprobe_config, **opts, &block)
      config.input input_file if input_file
      config.instance_eval(&block) if block_given?

      ffprobe_cmd(*config.to_args, ffprobe_bin: config.bin, **opts)
    end

    def ffprobe_json(config: ffprobe_config, **opts)
      config.input input_file if input_file
      config.instance_eval(&block) if block_given?
      config.print_format :json

      ffprobe(config: config, **opts)
    end

    class << self
      def config
        @config ||= FFprobeConfig.new
      end

      def configure(&block)
        config.instance_eval(&block) if block_given?
        config
      end

      def new_config
        config.clone
      end

      def ffprobe_cmd(*args, **kwargs)
        new.ffprobe_cmd(*args, **kwargs)
      end

      def ffprobe(*args, **kwargs, &block)
        new.ffprobe(*args, **kwargs, &block)
      end

      def ffprobe_json(*args, **kwargs, &block)
        new.ffprobe_json(*args, **kwargs, &block)
      end
    end
  end
end
