#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'mechanize'

agent = WWW::Mechanize.new
agent.open_timeout = 2
agent.read_timeout = 5
agent.set_proxy('myproxy', 8080, 'proxy_user', 'proxy_password')

