require_relative './minitest_helper'
require 'minitest/autorun'
require 'j_thread'

describe JThread do
  it "should compare using id" do
    thread1 = JThread.new(100, "BLOCKED", [])
    thread2 = JThread.new(200, "IN_NATIVE", [])

    (thread1 <=> thread2).must_equal -1
    (thread1 <=> thread1).must_equal 0
    (thread2 <=> thread1).must_equal 1
  end

end