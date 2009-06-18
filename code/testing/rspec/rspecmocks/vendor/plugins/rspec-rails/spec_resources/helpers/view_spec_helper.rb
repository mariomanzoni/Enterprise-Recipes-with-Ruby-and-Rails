#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ViewSpecHelper
  def method_in_helper
    "<div>This is text from a method in the ViewSpecHelper</div>"
  end

  def method_in_template_with_partial
    "<div>method_in_template_with_partial in ViewSpecHelper</div>"
  end

  def method_in_partial
    "<div>method_in_partial in ViewSpecHelper</div>"
  end
end
