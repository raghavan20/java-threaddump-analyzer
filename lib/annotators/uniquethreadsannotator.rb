class UniqueThreadsAnnotator
  def analyze(threadDump)
    hash = Hash.new
    threadDump.each {|thread|
      if hash.has_key?(thread.stacktrace)
        hash[thread.stacktrace] << thread.id
      else
        hash[thread.stacktrace] = [thread.id]
      end
    }
    hash.map {|k,v| "thread count: #{v.size}; threads: " << v.to_s << "\n" << k.join("\n")}
  end
end