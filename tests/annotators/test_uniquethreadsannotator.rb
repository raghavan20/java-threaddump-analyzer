require_relative '../minitest_helper'
require 'annotators/uniquethreadsannotator.rb'
require 'thread.rb'
require 'threaddump.rb'

describe UniqueThreadsAnnotator do
  before do
    stacktrace1 = ["java.lang.Object.wait(long) @bci=0 (Interpreted frame) ", "java.lang.ref.ReferenceQueue.remove(long) @bci=44, line=135 (Compiled frame)", "java.lang.ref.ReferenceQueue.remove() @bci=2, line=151 (Compiled frame)",
      "java.lang.ref.Finalizer$FinalizerThread.run() @bci=16, line=189 (Compiled frame)"]
    stacktrace2 = ["java.lang.Object.wait(long) @bci=0 (Interpreted frame)", "java.lang.Object.wait() @bci=2, line=503 (Compiled frame)",
      "java.lang.ref.Reference$ReferenceHandler.run() @bci=46, line=133 (Compiled frame)"]

    thread1 = JThread.new 100, "BLOCKED", stacktrace1
    thread2 = JThread.new 200, "BLOCKED", stacktrace1
    thread3 = JThread.new 300, "BLOCKED", stacktrace2
    thread4 = JThread.new 400, "BLOCKED", stacktrace2

    @threadDump = ThreadDump.new([thread1, thread2, thread3, thread4])
  end

  it "should return threads that have unique stack trace" do
    annotator = UniqueThreadsAnnotator.new
    expected = ["thread count: 2; threads: [100, 200]" << "\n" <<"java.lang.Object.wait(long) @bci=0 (Interpreted frame) " << "\n" << "java.lang.ref.ReferenceQueue.remove(long) @bci=44, line=135 (Compiled frame)" << "\n" << "java.lang.ref.ReferenceQueue.remove() @bci=2, line=151 (Compiled frame)" << "\n" << "java.lang.ref.Finalizer$FinalizerThread.run() @bci=16, line=189 (Compiled frame)",
      "thread count: 2; threads: [300, 400]" << "\n" << "java.lang.Object.wait(long) @bci=0 (Interpreted frame)" << "\n" << "java.lang.Object.wait() @bci=2, line=503 (Compiled frame)" << "\n" << "java.lang.ref.Reference$ReferenceHandler.run() @bci=46, line=133 (Compiled frame)"]

    annotator.analyze(@threadDump).must_equal expected
  end

end
