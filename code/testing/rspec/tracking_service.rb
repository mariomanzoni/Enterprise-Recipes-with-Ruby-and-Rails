#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'sinatra'

get '/package-history/:id' do
  builder do |xml|
    xml.instruct!
    xml.tag! 'package-history', :id => params[:id] do
      xml.steps do
        xml.step 'Received package', :ts => '2008-10-09 00:45'
        xml.step 'First delivery attempt', :ts => '2008-10-10 08:23'
        xml.step 'Receiver not at home', :ts => '2008-10-10 08:24'
        xml.step 'Second delivery attempt', :ts => '2008-10-11 09:51'
        xml.step 'Delivered', :ts => '2008-10-11 09:53'
      end
      xml.state 'delivered'
    end
  end
end
