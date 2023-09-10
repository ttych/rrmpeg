# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
SimpleCov.start

require 'rrmpeg'

require 'minitest/autorun'

require_relative 'helpers/tmp'
class Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
  include Test::Helpers::Tmp
end
