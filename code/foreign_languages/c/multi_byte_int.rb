#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'


class MultiByteIntegerReader
  def self.get_multibyte_integer(raw_data)
    multi_int = 0
    while raw_data[0][7] == 1
      multi_int = (multi_int << 7) | (raw_data.shift & 0x7f)
    end
    (multi_int << 7) | raw_data.shift
  end
end

  

require 'inline'
class MultiByteIntegerReader
  inline do |builder|
    builder.c_singleton <<-CSOURCE
    VALUE get_multibyte_integer_c(VALUE raw_data) {
      unsigned int multi_int     = 0;
      unsigned int current_value = FIX2INT(rb_ary_shift(raw_data));
      while ((current_value & 0x80)) {
        multi_int = (multi_int << 7) | (current_value & 0x7f);
        current_value = FIX2INT(rb_ary_shift(raw_data));
      }
      return INT2FIX((multi_int << 7) | current_value);
    }
    CSOURCE
  end
end


if __FILE__ == $0
  
  require 'benchmark'
  label_width = 6
  runs = 10_000_000
  Benchmark.bm(label_width) do |x|
    x.report('ruby: ') do
      1.upto(runs) do
        MultiByteIntegerReader.get_multibyte_integer([0x81, 0x06])
      end
    end
    x.report('C: ') do
      1.upto(runs) do 
        MultiByteIntegerReader.get_multibyte_integer_c([0x81, 0x06])
      end
    end
  end
  
end
