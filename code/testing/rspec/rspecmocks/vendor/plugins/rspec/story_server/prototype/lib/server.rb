#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'webrick'

class DispatchServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)
    File.open('story', 'w') do |io|
      io.write(request.body)
    end

    response.status = 200
    response['Content-Type'] = 'text/html'
    response.body = "body"
  end
end

params = { :Port        => 4000,
           :ServerType  => WEBrick::SimpleServer,
           :BindAddress => "0.0.0.0",
           :MimeTypes   => WEBrick::HTTPUtils::DefaultMimeTypes }
server = WEBrick::HTTPServer.new(params)
server.mount('/stories', DispatchServlet)
server.mount('/', WEBrick::HTTPServlet::FileHandler, File.dirname(__FILE__) + '/..', { :FancyIndexing => true })

trap("INT") { server.shutdown }
server.start