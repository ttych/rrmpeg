# frozen_string_literal: true

require 'test_helper'

describe Integer do
  describe '.to_filesize' do
    it 'returns 0.0 B for 0 Byte size' do
      assert_equal '0.0 B', 0.to_filesize
    end

    it 'returns 1.0 B for 1 Byte size' do
      assert_equal '1.0 B', 1.to_filesize
    end

    it 'returns 1.0 KiB for 1024 Byte size' do
      assert_equal '1.0 KiB', 1024.to_filesize
    end

    it 'returns 1.0 Mib for 1048576 Byte size' do
      assert_equal '1.0 MiB', 1_048_576.to_filesize
    end

    it 'returns 1.0 Gib for 1073741824 Byte size' do
      assert_equal '1.0 GiB', 1_073_741_824.to_filesize
    end

    it 'returns 1.0 Tib for 1099511627776 Byte size' do
      assert_equal '1.0 TiB', 1_099_511_627_776.to_filesize
    end

    it 'returns 1.0 PiB for 1125899906842624 Byte size' do
      assert_equal '1.0 PiB', 1_125_899_906_842_624.to_filesize
    end

    it 'returns 1.0 Eib for 1152921504606846976 Byte size' do
      assert_equal '1.0 EiB', 1_152_921_504_606_846_976.to_filesize
    end

    it 'returns 1.0 Zib for 1180591620717411303424 Byte size' do
      assert_equal '1.0 ZiB', 1_180_591_620_717_411_303_424.to_filesize
    end
  end
end
