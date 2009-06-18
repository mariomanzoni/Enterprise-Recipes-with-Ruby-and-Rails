#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class Mandator < ActiveRecord::Base
  has_many :messages
  validates_uniqueness_of :name

  def to_xml(options = {})
    options[:indent] ||= 2
    xml = options[:builder] ||= Builder::XmlMarkup.new(
      :indent => options[:indent]
    )
    xml.instruct! unless options[:skip_instruct]
    xml.mandator(
      'name' => self.name,
      'message_limit' => self.message_limit
    )
  end
end
