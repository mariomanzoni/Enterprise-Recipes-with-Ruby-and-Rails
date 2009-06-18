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
index_page = 'http://www.pragprog.com'
page = agent.get(index_page)
puts agent.visited?(index_page)           # -> true
puts agent.visited_page(index_page).title # -> The Pragmatic Bookshelf



class LinkCrawler < WWW::Mechanize
  def process
    home_page = get 'http://www.pragprog.com'
    home_page.links.with.href(/titles/).each do |link| 
      begin
        transact do
          book_page = click link
          # Now we are on a new page.
          print book_page.title
        end
        # We are on the home page again.
      rescue => ex
        puts ex
      end
      puts " (#{visited?(link.href)})"
    end
  end
end

LinkCrawler.new.process

