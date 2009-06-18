#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'cgi'

class PostData < Hash
  class_inheritable_accessor :required_fields, :instance_writer => false
  self.required_fields = []
  
  def []=(key, value)
    return if value.blank? && !required?(key)
    super
  end
  
  def to_post_data
    collect { |key, value| "#{key}=#{CGI.escape(value.to_s)}" }.join("&")  
  end
  
  alias_method :to_s, :to_post_data
  
  private
  def required?(key)
    required_fields.include?(key)
  end
end
