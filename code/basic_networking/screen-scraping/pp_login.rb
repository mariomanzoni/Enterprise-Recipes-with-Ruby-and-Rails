#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'logger'
require 'mechanize'

agent = WWW::Mechanize.new { |a| a.log = Logger.new('scrape.log') }
agent.user_agent_alias = 'Mac Safari'
page = agent.get('http://www.pragprog.com') 
page = agent.click page.links.text('Login')

login_form = page.forms.first 
login_form.email = ARGV[0]
login_form.password = ARGV[1]
agent.log.debug "Logging in with email address #{ARGV[0]}." 
login_form.checkboxes.name('remember_me').check 
page = agent.submit(login_form, login_form.buttons.first)

page.links.each { |link| puts link.text if link.text =~ /Ruby|Rails/ }
agent.click page.links.text('Log Out')

