#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class FixedLengthRecordFile
  include Enumerable 
  
  def initialize(source, field_sizes)
    if field_sizes.nil? or field_sizes.empty?
      raise ArgumentError, 'Please, pass field sizes!'
    end
    @file = source
    @field_pattern = get_pattern(field_sizes) 
  end
  
  def each 
    @file.each_line do |line|
      record = line.chomp.unpack(@field_pattern)
      record.map { |f| f.strip! }
      yield record 
    end
  end
  
  private
  
  def get_pattern(field_sizes)
    'A' + field_sizes.join('A')
  end
end

FLR = FixedLengthRecordFile # Saves some typing.



class FixedLengthRecordFile
  def self.open(path, mode, field_sizes) 
    file = File.open(path, mode)
    begin
      flr_file = new(file, field_sizes) 
      yield flr_file
    ensure
      file.close
    end
  end
  
  def <<(record) 
    @file.puts(record.map { |x| x.to_s}.pack(@field_pattern))
  end
end



require 'stringio'

class FixedLengthRecordFile
  def self.generate(field_sizes)
    buffer = StringIO.new 
    flr_file = new(buffer, field_sizes)
    yield flr_file
    buffer.close
    buffer.string
  end
end


# TODO: Add def headers(list of header names)
# TODO: Add def converter
