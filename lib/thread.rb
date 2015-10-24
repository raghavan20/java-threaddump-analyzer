class JThread
  attr_accessor :id, :state, :stacktrace
  def initialize(id, state, stacktrace)
    @id = id
    @state = state
    @stacktrace = stacktrace
  end

  def to_s
    output = ""
    output << "#{@id} #{@state}\n"
    output << @stacktrace.join("\n")
  end
  
  def <=> (other)
    id <=> other.id
  end
end

