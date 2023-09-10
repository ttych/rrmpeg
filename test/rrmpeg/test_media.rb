# frozen_string_literal: true

require 'test_helper'

describe RRmpeg::Media do
  describe '#at' do
    it 'returns a Media instance' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(ext: 'mp4')
        media = RRmpeg::Media.at(video_path)

        assert media
        assert_equal video_path, media.path
      end
    end
  end

  describe '#each' do
    it 'scans for all media in a directory' do
      in_tmpdir do |tmpdir|
        videos = tmpdir.add_tmpfiles(count: 4)

        media_paths = RRmpeg::Media.each(tmpdir.path).map(&:path)

        assert_equal videos, media_paths
      end
    end

    it 'filters on ext name' do
      in_tmpdir do |tmpdir|
        video1 = tmpdir.add_tmpfile(name: 'video1', ext: 'mp4')
        video2 = tmpdir.add_tmpfile(name: 'video2', ext: 'mp4')
        tmpdir.add_tmpfile(name: 'video3', ext: 'avi')

        media_paths = RRmpeg::Media.each(tmpdir.path, exts: [:mp4]).map(&:path)

        assert_equal [video1, video2], media_paths
      end
    end
  end

  describe '.new' do
    it 'can be instantiated from path' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(ext: 'mp4')
        media = RRmpeg::Media.new(video_path)

        assert media
        assert_equal video_path, media.path
      end
    end

    it 'raises error on non-existing file' do
      in_tmpdir do
        assert_raises RRmpeg::Error do
          RRmpeg::Media.new('mediamp4')
        end
      end
    end
  end

  describe '.dirname' do
    it 'returns Media dirname' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(ext: 'mp4')
        media = RRmpeg::Media.new(video_path)

        assert_equal tmpdir.path, media.dirname
      end
    end
  end

  describe '.basename' do
    it 'returns Media basename' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(name: 'video', ext: 'mp4')
        media = RRmpeg::Media.new(video_path)

        assert_equal 'video.mp4', media.basename
      end
    end
  end

  describe '.filename' do
    it 'returns Media filename' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(name: 'video', ext: 'mp4')
        media = RRmpeg::Media.new(video_path)

        assert_equal 'video', media.filename
      end
    end
  end

  describe '.extname' do
    it 'returns Media filename' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(ext: 'mp4')
        media = RRmpeg::Media.new(video_path)

        assert_equal 'mp4', media.extname
      end
    end
  end

  describe '.size' do
    it 'returns 0 for empty file size' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(ext: 'mp4')
        media = RRmpeg::Media.new(video_path)

        assert_equal 0, media.size
      end
    end
  end

  describe '.move_to' do
    it 'moves file to specified destination' do
      in_tmpdir do |tmpdir|
        video_path = tmpdir.add_tmpfile(name: 'video', ext: 'mp4')
        media = RRmpeg::Media.new(video_path)

        target = 'video2.avi'
        media.move_to(target)

        assert_equal File.join(tmpdir.path, target), media.path
        assert_equal 'avi', media.extname
        assert_equal 'video2', media.filename
      end
    end
  end
end
