#!/usr/bin/env ruby

require 'bio'

ff=Bio::FlatFile.open(nil,ARGV[0])
ff.each do |gb|
  next if gb == nil
  gb.each_gene do |feature|
    loc = feature.locations
    span = loc.span
    sz = span[1] - span[0] + 1
    h = feature.assoc
    strand = '+'
    strand = '-' if feature.position =~ /complement/ 
    puts "#{gb.acc_version}\t#{span[0]-1}\t#{span[1]}\t#{h['locus_tag']}\t500\t#{strand}\t#{span[0]-1}\t#{span[1]}\t0,0,0"
  end
end

