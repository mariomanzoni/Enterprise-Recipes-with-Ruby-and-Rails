#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ActionController #:nodoc:
  class TestResponse #:nodoc:
    attr_writer :controller_path

    def capture(name)
      template.instance_variable_get "@content_for_#{name.to_s}"
    end
    alias [] capture

  end
end
