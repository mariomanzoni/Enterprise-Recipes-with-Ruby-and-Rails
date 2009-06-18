#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class AccountChecker
  def check_account(bic, iban)
    if iban.to_i % 2 == 0
      ['National Bank', true]
    else
      [nil, false]
    end
  end
end



require 'soap/rpc/standaloneServer'

class AccountCheckerServer < SOAP::RPC::StandaloneServer
  def initialize(*args) 
    super 
    @log.level = Logger::Severity::DEBUG 
    add_servant(AccountChecker.new) 
  end 
end 



server = AccountCheckerServer.new(
  'Account Checker',    # Application Name
  'urn:AccountChecker', # Default Namespace
  '0.0.0.0',            # Host
  2000                  # Port
)
trap(:INT) { server.shutdown }
server.start 

