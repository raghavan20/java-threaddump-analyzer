class Parsers
  @@parsers = []
  @@parsernames = []
  def self.register(parser)
    @@parsernames << parser
    @@parsers << eval("#{parser}.new")
  end
  
  def self.list
    @@parsernames
  end

  def self.parse(io)
    parser = @@parsers.find {|p| p.supports(io)}
    raise Exception.new("no suitable parser found") if parser == nil
    io.rewind
    parser.parse(io)
  end

end
