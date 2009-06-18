#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Rails
    module VERSION #:nodoc:
      BUILD_TIME_UTC = 20080131122909
    end
  end
end

# Verify that the plugin has the same revision as RSpec
if Spec::Rails::VERSION::BUILD_TIME_UTC != Spec::VERSION::BUILD_TIME_UTC
  raise <<-EOF

############################################################################
Your RSpec on Rails plugin is incompatible with your installed RSpec.

RSpec          : #{Spec::VERSION::BUILD_TIME_UTC}
RSpec on Rails : #{Spec::Rails::VERSION::BUILD_TIME_UTC}

Make sure your RSpec on Rails plugin is compatible with your RSpec gem.
See http://rspec.rubyforge.org/documentation/rails/install.html for details.
############################################################################
EOF
end
