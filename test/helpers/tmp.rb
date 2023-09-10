# frozen_string_literal: true

require 'fileutils'

module Test
  module Helpers
    # tmp utilities for test
    module Tmp
      class Tmpdir
        attr_reader :path

        def initialize
          @path = File.realpath(Dir.mktmpdir)
        end

        def add_tmpfile(name: :file, ext: :tmp)
          tmpfile = File.expand_path("#{name}.#{ext}")
          FileUtils.touch tmpfile
          tmpfile
        end

        def add_tmpfiles(name: :file, ext: :tmp, count: 1)
          tmpfiles = []
          count.times do |count_index|
            tmpfiles << add_tmpfile(name: "#{name}.#{count_index}", ext: ext)
          end
          tmpfiles
        end

        def clean
          FileUtils.rm_rf(path) if path
        end
      end

      def in_tmpdir
        tmpdir = Tmpdir.new
        Dir.chdir(tmpdir.path) do
          yield tmpdir if block_given?
        end
      ensure
        tmpdir.clean
      end
    end
  end
end
