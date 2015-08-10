#!/usr/bin/env ruby
#
require 'bio'

window_size = ARGV[1].to_i
window_size = 5000 if window_size == nil or window_size < 1
#puts "track type=wiggle_0 name=gc_content description=gc_content_5kb_win"

ff = Bio::FlatFile.open(nil,ARGV[0])
ff.each do |fe|
  next if fe.entry_id == nil
  entry = fe.acc_version
  entry = fe.entry_id if entry == nil
  cur_win = 1
  puts "fixedStep chrom=#{entry} start=#{cur_win} step=#{window_size}"
  fe.naseq.window_search(window_size,window_size) do |winseq|
    puts winseq.gc_content.to_f * 100
    cur_win += window_size   
  end
end

