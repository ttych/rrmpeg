# frozen_string_literal: true

require 'test_helper'

class TestError < Minitest::Test
  def test_base_error_exists
    assert_raises RRmpeg::Error do
      raise RRmpeg::Error
    end
  end
end
