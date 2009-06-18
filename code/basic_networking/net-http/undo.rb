#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'webrick'
include WEBrick

class UndoServlet < HTTPServlet::AbstractServlet
  def do_UNDO(request, response)
    response.status = 200
    response.body = "Changes to #{request.path} have been undone.\n"
  end
end

server = HTTPServer.new(:Port => 4200)
server.mount('/', UndoServlet)
%w(INT TERM).each do |signal|
  trap(signal) { server.shutdown } 
end
server.start

