# frozen_string_literal: true

require 'test_helper'

describe RRmpeg::Configurable do
  let(:config_class) do
    Class.new do
      include RRmpeg::Configurable
    end
  end
  subject { config_class.new }

  describe 'InstanceMethods' do
    describe '.==' do
      it 'is true for 2 blank config of same class' do
        assert_equal subject, config_class.new
      end

      it 'is false for 2 instances of different class' do
        refute_equal subject, Object.new
      end
    end
  end

  describe 'ClassMethods' do
    describe '#var' do
      it 'allows variable definition on config with default' do
        config_class.var :bin, default: :TEST_BIN

        assert_equal :TEST_BIN, subject.bin
      end

      it 'allows variable set on config instance' do
        config_class.var :bin

        assert_nil subject.bin

        subject.bin :test

        assert_equal :test, subject.bin
      end
    end

    describe '#flag' do
      it 'allows flag definition on config with default' do
        config_class.flag :verbose, option: '-v', default: false

        refute subject.verbose
      end

      it 'allows flag set on config instance' do
        config_class.flag :verbose, option: '-v'

        refute subject.verbose
        subject.verbose true

        assert subject.verbose
      end
    end

    describe '#option' do
      it 'allows option definition on config with default' do
        config_class.option :input, option: '-i'

        assert_nil subject.input
      end

      it 'allows option set on config instance' do
        config_class.option :input, option: '-i'

        subject.input 'filename.txt'

        assert_equal 'filename.txt', subject.input
      end
    end

    describe '#arg' do
      it 'allows arg definition on config with default' do
        config_class.arg :file, default: 'filename.txt'

        assert_equal 'filename.txt', subject.file
      end

      it 'allows arg set on config instance' do
        config_class.arg :file

        assert_nil subject.file
        subject.file 'file.txt'

        assert_equal 'file.txt', subject.file
      end
    end

    # describe '#group' do
    #   it 'allows group definition on config' do
    #     config_class.group :input do
    #     end

    #     assert_equal nil, subject.input
    #   end

    # #   it 'allows group definition with nested element on config' do
    # #     config_class.group :input do
    # #       flag :verbose, option: '-v'
    # #     end

    # #     assert_equal nil, subject.input
    # #   end
    # end
  end
end

## duplicate object and equality
## mandatory ?
