require 'minitest/spec'
require 'minitest/autorun'
require "parsers/java7threaddumpparser.rb"

describe ThreadDump do
  it "should list all threads in the file" do
    file = File.open("./tests/resources/test.jstack")
    parser = Java7ThreadDumpParser.new

    threadDump = parser.parse(file)
 
    threadDump.count.must_equal 15
    firstThread = threadDump.first
    firstThread.stacktrace.size.must_equal 9
    firstThread.state.must_equal "BLOCKED"
    firstThread.id.must_equal "25995"
  end
end
