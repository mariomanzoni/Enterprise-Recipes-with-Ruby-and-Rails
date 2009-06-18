#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'active_merchant'

ActiveMerchant::Billing::Base.mode = :test
gateway = ActiveMerchant::Billing::BraintreeGateway.new( 
  :login => 'demo',
  :password => 'password'
)

credit_card = ActiveMerchant::Billing::CreditCard.new( 
  :first_name => 'Maik',
  :last_name => 'Schmidt',
  :number => '4111111111111111',
  :month => '10',
  :year => (Time.now.year + 1).to_s,
  :verification_value => '999'
)

options = {
  :billing_address => {
    :name => 'Maik Schmidt',
    :address1 => 'Musterstraße 42',
    :city => 'Musterstadt',
    :state => 'XX',
    :country => 'US',
    :zip => 'X12345',
    :phone => '555-123-4567'
  },
  :description => 'Beer Anthology (PDF)'
}

if !credit_card.valid? 
  puts 'Credit card is invalid!'
  credit_card.errors.each_full { |m| puts m }
else
  amount_in_cents = 699
  response = gateway.purchase( 
    amount_in_cents, credit_card, options
  )
  if response.success?
    puts "We've got the money!"
    puts "Transaction ID: #{response.authorization}"
    if response.avs_result['code'] != 'Y' 
      puts "Address is suspicious:\n#{response.avs_result['message']}"
    end
  else
    puts "Could not purchase the product:\n#{response.message}"
  end
end


if !credit_card.valid?
  puts 'Credit card is invalid!'
  credit_card.errors.each_full { |m| puts m }
else

  amount_in_cents = 1000
  response = gateway.authorize(amount_in_cents, credit_card, options) 
  if response.success?
    puts "Amount has been authorized!"
    puts "Transaction ID: #{response.authorization}"
    response = gateway.capture(amount_in_cents, response.authorization) 
    if response.success?
      puts "We've got the money!"
    else
      puts "Could not capture the money:\n#{response.message}"
    end
  else
    puts "Could not authorize transaction:\n#{response.message}"
  end

end
