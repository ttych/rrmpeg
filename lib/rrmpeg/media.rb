# frozen_string_literal: true

module RRmpeg
  class Media
    attr_reader :path

    def initialize(path)
      @path = path

      load_media
    end

    def dirname
      File.dirname(path)
    end

    def basename
      File.basename(path)
    end

    def filename
      File.basename(path, File.extname(path))
    end

    def extname
      File.extname(path).delete_prefix('.')
    end

    def size
      File.size(path)
    end

    def move_to(dest, force: false)
      dest = File.expand_path(dest)
      dest = File.join(dest, basename) if File.directory?(dest)

      if File.exist?(dest) && !force
        raise RRmpeg::Error, "cannot move #{path} to #{dest}, #{dest} already exists"
      end

      FileUtils.mv(path, dest, force: true)
      @path = dest
    end

    private

    def load_media
      raise(RRmpeg::Error, "#{path} is not a Media file") unless File.file?(path)
    end

    class << self
      def at(path)
        new(path)
      end

      def each(path = '.', pattern: '*', exts: [])
        exts = exts.map(&:to_sym)

        Dir.glob(File.join(File.expand_path(path), pattern)).map do |media_path|
          media = Media.at(media_path)
          next if exts.any? && !exts.include?(media.extname.to_sym)

          yield media if block_given?
          media
        rescue RRmpeg::Error => e
          warn e
        end.compact
      end
    end
  end
end
