#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
God::Contacts::Email.message_settings = {
  :from => 'god@example.com' 
}

God::Contacts::Email.server_settings = {
  :address => 'smtp.example.com',
  :port => 25,
  :domain => 'example.com',
  :authentication => :plain,
  :user_name => 'sysadm',
  :password => 't0p$ecret'
}

God.contact(:email) do |c|
  c.name = 'admin'
  c.email = 'admin@example.com'
end

God.contact(:email) do |c|
  c.name = 'boss'
  c.email = 'boss@example.com'
end
