#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class LocalFileMessageSender
  def initialize(target_dir)
    @target_dir = target_dir
  end
  
  def send(message_id, content)
    filename = "#{message_id}.xml"
    File.open(File.join(@target_dir, filename), 'w') do |file|
      file.write(content)
    end
  end
end


if $0 == __FILE__
  
  sender = LocalFileMessageSender.new('data/in')
  message = "<?xml version='1.0'?>\n<order id='0815'/>\n"
  sender.send('order-0815', message)
  
end
