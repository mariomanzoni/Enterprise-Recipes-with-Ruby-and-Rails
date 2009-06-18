#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
steps_for :multiline_steps do
  Given "I have a two line step with this text:$text" do |text|
    @text = text
  end

  When "I have a When with the same two lines:$text" do |text|
    text.should == @text
  end

  Then "it should match:$text" do |text|
    text.should == @text
  end
end