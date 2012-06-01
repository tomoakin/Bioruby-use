#!/bin/env ruby

require 'bio'

ff = Bio::FlatFile.new(nil, ARGF)

while fe = ff.next_entry
  puts "#{fe.entry_id}\t#{fe.seq.length}"
end

