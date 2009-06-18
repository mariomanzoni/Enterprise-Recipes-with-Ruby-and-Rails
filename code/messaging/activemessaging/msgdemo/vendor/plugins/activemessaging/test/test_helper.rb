#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# load the rails environment
# TODO currently requires you to run tests as a installed plugin, we should try to fix this
ENV['RAILS_ENV'] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")

# load other libraries
require 'test/unit'

# load activemessaging
# TODO this is already loaded automatically by starting Rails
# but we may need to do this if we want to run a13g tests without Rails
#require File.dirname(__FILE__) + '/../lib/activemessaging/processor'
#require File.dirname(__FILE__) + '/../lib/activemessaging/gateway'
require File.dirname(__FILE__) + '/../lib/activemessaging/test_helper'


