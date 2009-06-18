#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'random/online'


class RandomBytesPool
  def initialize(poolsize = 1024, source = Random::RandomOrg.new)
    @poolsize = poolsize
    @random_source = source
    @position = @poolsize + 1
  end
  
  def next
    if @position >= @poolsize
      @pool = @random_source.randbyte(@poolsize)
      @position = 0
    end
    @position += 1
    @pool[@position - 1]
  end
end



require 'ngrams'

module Ngram
  class Dictionary
    @@random_bytes_pool = RandomBytesPool.new
    
    def rand
      @@random_bytes_pool.next / 255.0
    end
  end
end



require 'ngrams'

class PasswordGenerator
  def initialize(file = Ngram::Dictionary::DEFAULT_STORE)
    @dictionary = Ngram::Dictionary.load(file)
  end
  
  def generate_password(length)
    @dictionary.word(length)
  end
end



generator = PasswordGenerator.new
3.times { puts generator.generate_password(12) }

