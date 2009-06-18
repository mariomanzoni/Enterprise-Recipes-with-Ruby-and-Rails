#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Utils #:nodoc:
    def generate_unique_id
      md5 = Digest::MD5.new
      now = Time.now
      md5 << now.to_s
      md5 << String(now.usec)
      md5 << String(rand(0))
      md5 << String($$)
      md5 << self.class.name
      md5.hexdigest
    end
    
    module_function :generate_unique_id
  end
end