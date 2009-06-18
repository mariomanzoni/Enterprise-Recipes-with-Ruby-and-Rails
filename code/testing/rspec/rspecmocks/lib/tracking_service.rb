#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'open-uri'
require 'rexml/document'

class TrackingService
  def initialize(url = 'http://localhost:4567')
    @url = url
  end
  
  def track(tracking_number)
    request_uri = "#{@url}/package-history/#{tracking_number}"
    doc = REXML::Document.new(open(request_uri).read)
    doc.elements['/package-history/state'].text
  end
end


if __FILE__ == $0
  ts = TrackingService.new('http://localhost:4567')
  puts ts.track(ARGV[0] || '42')
end
