#!/bin/env ruby

class PBreadlengths
  def initialize(str = nil)
    @read_name = str
    @lengths = Array.new
  end
  def add_subread(length)
    @lengths << length
  end
  def sameread(readname)
    return readname == @read_name
  end
  def print
    str = "#{@read_name}\t#{@lengths.max}\t#{@lengths.join(' ')}" 
    puts str unless str == "\t\t"
  end
end
require 'bio'
ff = Bio::FlatFile.new(Bio::Fastq, ARGF)
lastread = ""
lastread = PBreadlengths.new
while fe = ff.next_entry
  ary=fe.entry_id.split("/")
  readname = "#{ary[0]}/#{ary[1]}"
  if lastread.sameread(readname)
    lastread.add_subread(fe.seq.length)
  else
    lastread.print
    lastread = PBreadlengths.new(readname)
    lastread.add_subread(fe.seq.length)
  end
end
lastread.print
