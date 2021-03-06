#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# stub frameworks like to gum up Object, so this is deliberately
# set NOT to run so that you don't accidentally run it when you
# run this dir.

# To run it, stand in this directory and say:
#
#   RUN_FLEXMOCK_EXAMPLE=true ruby ../bin/spec mocking_with_flexmock.rb

if ENV['RUN_FLEXMOCK_EXAMPLE']
  Spec::Runner.configure do |config|
    config.mock_with :flexmock
  end

  describe "Flexmocks" do
    it "should fail when the expected message is received with wrong arguments" do
      m = flexmock("now flex!")
      m.should_receive(:msg).with("arg").once
      m.msg("other arg")
    end

    it "should fail when the expected message is not received at all" do
      m = flexmock("now flex!")
      m.should_receive(:msg).with("arg").once
    end
  end
end
