require_relative './minitest_helper'
require "./lib/parsers/java7threaddumpparser.rb"

describe Java7ThreadDumpParser do
  
  before do
    file = File.open("./tests/resources/test.jstack")
    @threadDump = Java7ThreadDumpParser.new.parse(file)
  end

  it "should list all thread ids in the file" do
    threadIds=["25995","25988","25964","25961","9931","9930","9819","9818","9817","9815","9813","9812","9811","9810","9797"]

    @threadDump.listAllThreads.must_equal threadIds
  end
  
  it "should list unique states of threads" do
   @threadDump.uniqueStates().must_equal ["BLOCKED", "IN_NATIVE", "IN_JAVA"]
  end
  
  it "should list threads matching state" do
    @threadDump.getByState("IN_NATIVE").must_equal ["25988", "9797"]
  end
  
  it "should return threads matching thread ids" do
    ids = ["25995", "9813"]
    threads = @threadDump.getById(ids)
    
    threads.count.must_equal 2
    threads.map {|t| t.id}.must_equal ids
  end
end
