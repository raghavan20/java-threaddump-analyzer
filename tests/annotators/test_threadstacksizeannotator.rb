require_relative '../minitest_helper'
require 'annotators/threadstacksizeannotator.rb'
require "parsers/java7threaddumpparser.rb"

describe ThreadStackSizeAnnotator do
  before do
    file = File.open("./tests/resources/smaller.jstack")
    @threadDump = Java7ThreadDumpParser.new.parse(file)
  end
  
  it "should list thread count for all unique stack size count" do
    @annotator = ThreadStackSizeAnnotator.new
    
    expected=["Line count: 9; thread count: 1", 
    "Line count: 4; thread count: 2",
    "Line count: 3; thread count: 1",
    "Line count: 0; thread count: 1"]
    
    @annotator.analyze(@threadDump).must_equal expected
    
   end
  
end
