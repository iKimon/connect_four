require "test_helper"

describe ConnectFour::Board do
  subject { ConnectFour::Board }
  it "can be initialized with an empty 8x8 array" do
    expected = Array.new(8, Array.new(8))
    actual = subject.new.board

    assert_equal expected, actual
    assert false
  end
end
