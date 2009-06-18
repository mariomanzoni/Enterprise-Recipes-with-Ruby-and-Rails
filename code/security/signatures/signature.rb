#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'openssl'

def generate_key_pair(name)
  private_key = OpenSSL::PKey::RSA.generate(1024) 
  File.open("#{name}_private.pem", 'w+') do |f|
    f.puts private_key.to_pem
  end
  File.open("#{name}_public.pem", 'w+') do |f|
    f.puts private_key.public_key.to_pem 
  end
end
generate_key_pair('alice')
generate_key_pair('bob')

def key(name)
  OpenSSL::PKey::RSA.new(File.read("#{name}.pem"))
end



alice_private_key = key('alice_private')
alice_public_key = key('alice_public')
bob_public_key = key('bob_public')
plaintext = "Alice's extremely important message!"
ciphertext = bob_public_key.public_encrypt(plaintext) 
signature = alice_private_key.private_encrypt(plaintext) 



bob_private_key = key('bob_private')
plaintext = bob_private_key.private_decrypt(ciphertext) 
if alice_public_key.public_decrypt(signature) == plaintext 
  puts "Signature matches."
  puts "Got: #{plaintext}"
else
  puts 'Signature did not match!'
end



plaintext = "Alice's extremely important message!"
ciphertext = bob_public_key.public_encrypt(plaintext)
digest = OpenSSL::Digest::SHA1.new
signature = alice_private_key.sign(digest, plaintext) 



bob_private_key = key('bob_private')
plaintext = bob_private_key.private_decrypt(ciphertext)
digest = OpenSSL::Digest::SHA1.new
if alice_public_key.verify(digest, signature, plaintext) 
  puts "Signature matches."
  puts "Got: #{plaintext}"
else
  puts 'Signature did not match!'
end

