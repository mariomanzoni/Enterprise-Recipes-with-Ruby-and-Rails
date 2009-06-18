#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'inline'

class MessagePrinter
  inline(:C) do |builder|
    builder.include '<iostream>' 
    builder.include '<string>' 
    builder.add_compile_flags '-x c++', '-lstdc++' 
    builder.c <<-CSOURCE
    void shout_message(int i, char* message) {
      std::string upperCase = std::string(message);
      std::transform(
        upperCase.begin(), upperCase.end(),
        upperCase.begin(), ::toupper
      );
      while (i-- > 0)
        std::cout << upperCase << std::endl;
    }
    CSOURCE
  end
end



MessagePrinter.new.shout_message 3, 'Hello, world!'

