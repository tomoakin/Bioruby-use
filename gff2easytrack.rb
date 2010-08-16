#/usr/local/bin/ruby

require 'bio'

#transcriptgff = 'TAIR9_GFF3_genes.gff'
genearray=Array.new
mRNAhash=Hash.new
exonhash=Hash.new
tehash=Hash.new

lastid = ''
lastrecord = nil
ARGF.each_line do |gffline|
  record=Bio::GFF::GFF3::Record.new(gffline)
  feature_type = record.feature_type
  if(feature_type == 'gene')
    genearray << record.id
#    STDOUT.puts record.id
#    p record
  elsif(feature_type == 'mRNA')
    parent = record.get_attribute('Parent')
#    STDOUT.puts record.id
#    p record
    if mRNAhash[parent] == nil
      mRNAhash[parent] = [record]
    else 
      mRNAhash[parent] << record
    end
  elsif(feature_type == 'transposable_element')
# not yet implemented
  elsif(feature_type == 'exon')
    parents = record.get_attributes('Parent')
    parents.each do |parent|
      if exonhash[parent] == nil
        exonhash[parent] = Array.new
      end
      exonhash[parent] << record
    end
  end
end
genearray.each do |gene|
  mRNAs=mRNAhash[gene]
  mRNAs.each do |mRNA|
    print "gene target=#{mRNA.seqname} name=#{mRNA.id} strand=#{mRNA.strand} range=#{mRNA.start},#{mRNA.end} ";
    exonary=exonhash[mRNA.id]
    exonary.each do |exon|
      print "exon=#{exon.start},#{exon.end} "
    end
    print "\n"
  end
end
