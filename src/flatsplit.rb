#!/usr/bin/ruby
require 'bio'

ff = Bio::FlatFile.open(nil, ARGV[0])
maxcount = (ARGV[1].to_i or 1000)
maxdir = 100
filecount=0
dircount = 0
count=maxcount
owd = Dir.getwd
while fe = ff.next_entry
  if filecount % maxdir == 0 && count % maxcount == 0
    Dir.chdir(owd)
    dircount += 1
    newdir = (ARGV[0] + "." + dircount.to_s)
    Dir.mkdir(newdir)
    Dir.chdir(newdir)
  end
  if count == maxcount then
    filecount += 1
    of=open(ARGV[0]+"."+filecount.to_s,"w")
    count = 0
  end
  of.print fe.to_s
  count += 1
end
