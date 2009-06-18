#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ActionController
  class Base
    class << self
      def set_view_path(path)
        [:append_view_path, :view_paths=, :template_root=].each do |method|
          if respond_to?(method)
            return send(method, path)
          end
        end
      end
    end
  end
end
        
