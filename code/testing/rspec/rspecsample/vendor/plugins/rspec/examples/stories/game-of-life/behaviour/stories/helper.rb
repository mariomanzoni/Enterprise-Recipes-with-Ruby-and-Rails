#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.expand_path("#{dir}/../../../../../../rspec/lib"))
require 'spec'
$LOAD_PATH.unshift(File.expand_path("#{dir}/../../"))
require "#{dir}/../../life"
require File.join(File.dirname(__FILE__), *%w[steps])