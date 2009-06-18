#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'wbmp_image'

class ImageController < ApplicationController
  def convert
    raw_data = params[:image][:file_data].string.unpack('C*') 
    image = WbmpImage.from_raw_data(raw_data)
    @ascii_art = image.to_ascii_art
  end
end
