xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8' # <label id="code.xml.instruct"/>
xml.customer('customer-no' => @customer.customer_no) do
  xml.name(
    :forename => @customer.forename,
    :surname => @customer.surname
  )
  xml.street(@customer.street)
  xml.city(@customer.city)
  xml.tag!('postal-code', @customer.postal_code) # <label id="code.xml.tag"/>
end
