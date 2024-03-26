require_relative 'test_helper'

class JekyllQrGeneratorTest < Minitest::Test
  def test_it_is_a_module
    assert_kind_of Module, JekyllQrGenerator
  end

  def test_that_it_has_a_version_number
    refute_nil ::JekyllQrGenerator::VERSION
  end
end
