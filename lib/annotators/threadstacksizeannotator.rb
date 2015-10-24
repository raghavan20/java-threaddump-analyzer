class ThreadStackSizeAnnotator
  def analyze(threadDump)
    hash = Hash.new
    threadDump.each {|thread| 
      totalLines = thread.stacktrace.size
      if hash.has_key? totalLines
        hash[totalLines] = hash[totalLines] + 1
      else
        hash [totalLines] = 1
      end
    }
    hash = hash.sort_by {|k,v| k}.reverse
    hash.map {|k,v| "Line count: #{k}; thread count: #{v}" }
  end
end