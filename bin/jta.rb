#!/usr/bin/ruby

require 'optparse'
require './lib/parsers/parsers.rb'
require './lib/parsers/java7threaddumpparser.rb'
require './lib/annotators/threadstacksizeannotator.rb'
require './lib/annotators/uniquethreadsannotator.rb'


options = {}
argv = ARGV # copy args

OptionParser.new { |opts|
  opts.banner = "Usage: java threaddump analyzer [options]"
  opts.on("-f", "--file threadump", "threaddump file") { |v| options[:file] = v }
  opts.on("-l", "--listthreads", "list all threads") { |v| options[:listall] = v }
  opts.on("-u", "--uniquethreadstatus", "unique thread status") {  |v| options[:uniquestates] = true}
  opts.on("-s", "--matchingstate state", "threads matching state") {  |v| options[:state] = v}
  opts.on("-t", "--threadid thread1,thread1,threadN", Array, "thread(s) matching ids") {  |v| options[:threads] = v}
  opts.on("--printfile", "print whole file") {  |v| options[:printfile] = true}
  opts.on("--printstacks", "print thread stacks") {  |v| options[:printstacks] = true}
  opts.on("--parsers", "print available parsers") {  |v| options[:parsers] = true}
  opts.on("-a", "--annotate", "annotate thread dump") {|v| options[:annotate] = true}
   
  opts.on_tail("-h", "--help") { puts opts; exit}
}.parse!
#p options


if options.include? :parsers
  puts Parsers.list
  abort
end

abort "thread dump file required: -f" unless options[:file]
file=File.open options[:file]

threadDump = Parsers.parse file

if options.include? :listall
  puts threadDump.listAllThreads.sort.join(", ")
elsif options.include? :uniquestates
  puts threadDump.uniqueStates
elsif options.include? :state
  threadIds = threadDump.getByState(options[:state])
  puts threadIds.sort.join(", ")
  puts threadDump.getById(threadIds) if options.include? :printstacks
elsif options.include? :threads
  puts threadDump.getById(options[:threads])
elsif options.include? :printfile
  file.rewind
  puts file.read
elsif options.include? :annotate
  puts ThreadStackSizeAnnotator.new.analyze(threadDump).join("\n")
  puts UniqueThreadsAnnotator.new.analyze(threadDump).join("\n\n")
end

  
  
