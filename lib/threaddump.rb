require 'thread.rb'

class ThreadDump
  include Enumerable
  
  def initialize(threads)
    @threads = threads
    @byid = Hash.new
    @threads.each{|thread|
      @byid[thread.id] = thread
    }

    @bystate = Hash.new
    @threads.each {|thread|
      if @bystate.has_key? thread.state
      @bystate[thread.state] << thread
      else
        @bystate[thread.state] = [thread]
      end
    }
  end
  
  def each(&block)
    @threads.each(&block)
  end
  
  def listAllThreads()
    @threads.map {|t| t.id}
  end

  def uniqueStates()
    @bystate.keys
  end
  
  def getByState(state)
    @bystate[state].map {|thread| thread.id}
  end

  def getById(ids)
    result=[]
    ids.each { |id| result << @byid[id]}
    result
  end
end