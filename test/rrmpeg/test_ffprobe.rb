# frozen_string_literal: true

require 'test_helper'

describe RRmpeg::FFprobe do
  subject { RRmpeg::FFprobe.new }

  describe '#configure' do
    it 'allows to configure ffprobe' do
      config = RRmpeg::FFprobe.configure do
        bin :ffprobe
      end

      assert_equal RRmpeg::FFprobe.config, config
    end
  end

  describe '#new_config' do
    it 'generates a config based on default ffprobe config' do
      refute_same RRmpeg::FFprobe.config, RRmpeg::FFprobe.new_config
      assert_equal RRmpeg::FFprobe.config, RRmpeg::FFprobe.new_config
    end
  end

  describe '#ffprobe_cmd' do
    it 'submits system call through capture2' do
      # FIXME
    end
  end

  describe '#ffprobe' do
    it 'use global config by default' do
      # FIXME
    end

    it 'allows configuration through block' do
      # FIXME
    end

    it 'forwards call to ffprobe_cmd' do
      # FIXME
    end
  end

  describe '#ffprobe_json' do
    it 'forces print_format to json by default' do
      # FIXME
    end

    it 'allows configuration through block' do
      # FIXME
    end

    it 'forwards call to ffprobe' do
      # FIXME
    end
  end

  describe '.config' do
    it 'gives access to the base instance config based on FFprobe config' do
      refute_same RRmpeg::FFprobe.config, subject.config
      assert_equal RRmpeg::FFprobe.config, subject.config
    end
  end
end
