#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# Used just for us to develop rspec with Autotest
# We could symbolic link rspec/vendor/plugins/rspec => rspec/., but 
# this leads to a problem with subversion on windows.  Autotest
# uses Ruby's load path, which contains ".", so this is a workaround
# (albeit, an unclean one)
require File.dirname(__FILE__) + "/../lib/autotest/discover.rb"
