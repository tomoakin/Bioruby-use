#!/usr/bin/env ruby
# This program reads sequence from standard input or a file specified in the
# command line and print out the gc content in a fixed window.

# The output comprise the central coordinate of the windown and the 
# average gc content of the window.

require 'bio'

window_size = 5000

cur_win = window_size / 2 

ff=Bio::FlatFile.new(nil,ARGF)
fe=ff.next_entry
fe.naseq.window_search(window_size,window_size) do |winseq|
  puts "#{cur_win}\t#{winseq.gc_content.to_f}"
  cur_win += window_size   
end

