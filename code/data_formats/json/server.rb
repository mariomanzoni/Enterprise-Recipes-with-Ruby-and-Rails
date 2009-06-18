#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'json'
require 'webrick'

include WEBrick

def start_webrick(config = {})
  config.update(:Port => 8080)     
  server = HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each do |signal| 
    trap(signal) { server.shutdown }
  end
  server.start
end

class EScoreServlet < HTTPServlet::AbstractServlet
  def do_POST(req, resp)
    persons = JSON.parse(req.body)
    result = persons.inject([]) do |result, person|
      result << { 'id' => person ['id'], 'escore' => rand(9) }
    end
    resp.body = result.to_json
    raise HTTPStatus::OK
  end
end

start_webrick do |server|
  server.mount('/e-score', EScoreServlet) 
end
