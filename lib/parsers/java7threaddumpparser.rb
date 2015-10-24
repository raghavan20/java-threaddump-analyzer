require 'parsers/parsers.rb'
require 'j_thread'
require 'threaddump.rb'

class Java7ThreadDumpParser
  Parsers.register self

  def supports(io)
    while true
      break if io.eof?
      line = io.readline
      if line.start_with?("Thread ")
        return extractThread(line, io)
      end
    end
  end

  def parse(io)
    threads = []
    while true
      break if io.eof?
      line = io.readline
      if line.start_with?("Thread ")
        threads << extractThread(line, io)
      end
    end
    ThreadDump.new threads
  end

  def extractThread(line, io)
    (id, state) = parseThreadLine(line)
    if (id == nil or state == nil)
      #raise Exception.new "id or state is null"
      nil
    else
      JThread.new(id, state, extractStackTrace(io))
    end
  end

  def extractStackTrace(io)
    stacktrace=[]
    while true
      break if io.eof?
      line  = io.readline
      break unless line.start_with?(" - ")
      stacktrace << line.match(/ - (.*)/)[1]
    end
    stacktrace
  end

  def parseThreadLine(line)
    matched = line.match(/Thread\s*(\d+):.*?state\s*=\s*(.*?)\)/)
    return matched[1], matched[2] if matched != nil
  end
end

