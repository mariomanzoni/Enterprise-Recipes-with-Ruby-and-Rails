#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'hpricot'
require 'open-uri'

class VcardController < ApplicationController
  def import
    external_url = params[:external_url]
    doc = Hpricot(open(external_url)) 
    @vcard = Vcard.new
    @vcard.url = doc.at('//a[@class="url"]')['href'] 
    @vcard.name = classified_node(doc, 'fn')
    @vcard.street = classified_node(doc, 'street-address')
    @vcard.city = classified_node(doc, 'locality')
    @vcard.postal_code = classified_node(doc, 'postal-code')
    @vcard.country = classified_node(doc, 'country-name')
    @vcard.phone = classified_node(doc, 'tel')
    @vcard.email = classified_node(doc, 'email')
  end
  
  private
  
  def classified_node(doc, class_name)
    doc.at("//[@class='#{class_name}']").inner_html  
  end
end



require 'mofo'

class VcardController
  def import_mofo
    @vcard = hCard.find :first => params[:external_url]
  end
end

