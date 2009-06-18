#!/usr/local/bin/ruby -w
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'stringio'
require 'test/unit'
require 'flrfile'

class FixedLengthRecordFileTest < Test::Unit::TestCase
  def test_illegal_field_sizes
    [nil, []].each do |illegal_size|
      assert_raises(ArgumentError) {
        FixedLengthRecordFile.new(StringIO.new(''), illegal_size)
      }
    end
  end
  
  def test_read_single_line_from_file_object
    output_file = '/tmp/single.flr'
    f = File.new(output_file, 'w+')
    f.puts('Maik      Schmidt   ')
    f.close
    flr_file = FLR.new(File.new(output_file), [10, 10])
    result = []
    flr_file.each { |row| result << row }
    assert_equal([['Maik', 'Schmidt']], result)
    File.delete(output_file)
  end
      
  def test_read_single_line_from_stringio_object
    f = StringIO.new('Maik      Schmidt   ')
    flr_file = FLR.new(f, [10, 10])
    result = []
    flr_file.each { |row| result << row }
    assert_equal([['Maik', 'Schmidt']], result)
  end
      
  def test_write_single_line_to_file_object
    output_file = '/tmp/single.flr'
    FLR.open(output_file, 'w', [2, 2, 3]) do |flr|
      flr << %w(a b c)
    end
    assert_equal("a b c  \n", IO::read(output_file))
    File.delete output_file
  end
  
  def test_write_several_lines_to_file_object
    output_file = '/tmp/single.flr'
    FLR.open(output_file, 'w', [4, 2, 3]) do |flr|
      flr << %w(a b c)
      flr << %w(mean be the)
    end
    assert_equal("a   b c  \nmeanbethe\n", IO::read(output_file))
    File.delete output_file
  end
  
  def test_write_single_line_to_stringio_object
    result = FLR.generate([2, 2, 3]) do |flr|
      flr << %w(a b c)
    end
    assert_equal("a b c  \n", result)
  end
  
  def test_write_several_lines_to_stringio_object
    result = FLR.generate([2, 1, 3]) do |flr|
      flr << %w(a b c)
      flr << %w(am b de)
    end
    assert_equal("a bc  \nambde \n", result)
  end
end
