#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'net/ldap'

class User
  BASE = 'dc=enterpriserecipes,dc=com'
  LDAP_USER = 'cn=root,dc=enterpriserecipes,dc=com'
  LDAP_PASSWORD = 't0p$ecret'
  
  def self.authenticate(email, password)
    email_filter = Net::LDAP::Filter.eq('mail', email) 
    ldap_con = connect(LDAP_USER, LDAP_PASSWORD)
    dn = ''
    ldap_con.search(:base => BASE, :filter => email_filter) do |entry| 
      dn = entry.dn
    end
    !dn.empty? and connect(dn, password).bind
  end

  private
  
  def self.connect(dn, password) 
    Net::LDAP.new(
      :host => 'localhost', 
      :port => 389,
      :auth => {
        :method   => :simple,
        :username => dn,
        :password => password
      }
    ) 
  end
end



if User.authenticate('Maik.Schmidt@example.com', 'maik123')
  puts 'You are logged in!'
else
  puts 'Sorry!'
end

