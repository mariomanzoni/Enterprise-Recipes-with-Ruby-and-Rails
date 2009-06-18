#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'active_merchant/billing/integrations/notification'
require 'active_merchant/billing/integrations/helper'
require 'active_merchant/billing/integrations/return'
require 'active_merchant/billing/integrations/bogus'
require 'active_merchant/billing/integrations/chronopay'
require 'active_merchant/billing/integrations/paypal'
require 'active_merchant/billing/integrations/nochex'
require 'active_merchant/billing/integrations/gestpay'
require 'active_merchant/billing/integrations/two_checkout'
require 'active_merchant/billing/integrations/hi_trust'

# make the bogus gateway be classified correctly by the inflector
Inflector.inflections do |inflect|
  inflect.uncountable 'bogus'
end
