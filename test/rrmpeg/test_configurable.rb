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

      it 'allows variable definition on config' do
        config_class.var :bin

        assert_nil subject.bin

        subject.bin :test

        assert_equal :test, subject.bin
      end
    end
  end
end

## duplicate object and equality
