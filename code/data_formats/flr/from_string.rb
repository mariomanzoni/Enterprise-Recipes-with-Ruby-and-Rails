#!/usr/bin/env ruby
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---


require 'stringio'
require 'flrfile'

content = <<CONTENT
10112012010hdzNOEyP62uyhTYiignW8Q==                    Maik Schmidt
019950820098MxbHUfW/Z8Wv1WLZeeO231rH5BKos/FasPFcHxYQMc=John Doe
00300122009DkiZJkx9uNkBN2n1JwuQxM26ueVYQOrtodP94T8Zcj8=Jane Rodriguez
CONTENT

parser = FLR.new(StringIO.new(content), [5, 6, 44, 40])
puts parser.inject(0) { |total, row| total += row[0].to_f / 100 }

