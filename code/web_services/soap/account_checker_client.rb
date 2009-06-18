#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'soap/rpc/driver' 

account_checker = SOAP::RPC::Driver.new( 
  'http://localhost:2000',
  'urn:AccountChecker'
)
account_checker.add_method('check_account', 'bic', 'iban') 

bic, iban = ARGV
name, status = account_checker.check_account(bic, iban)
if status
  puts "Account is OK and belongs to #{name}."
else
  puts 'Account is not OK.'
end
