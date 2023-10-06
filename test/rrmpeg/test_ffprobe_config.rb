# frozen_string_literal: true

require 'test_helper'

describe RRmpeg::FFprobeConfig do
  subject { RRmpeg::FFprobeConfig.new }

  describe '.bin' do
    it 'defines default ffprobe bin' do
      assert_equal 'ffprobe', subject.bin
    end

    it 'allows ffprobe bin redefinition' do
      subject.bin 'test_ffprobe'

      assert_equal 'test_ffprobe', subject.bin
    end
  end
end
