#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ExplicitHelper
  def method_in_explicit_helper
    "<div>This is text from a method in the ExplicitHelper</div>"
  end
  
  # this is an example of a method spec'able with eval_erb in helper specs
  def prepend(arg, &block)
    begin # rails edge after 2.1.0 eliminated need for block.binding
      concat(arg) + block.call
    rescue
      concat(arg, block.binding) + block.call
    end
  end
  
  def named_url
    rspec_on_rails_specs_url
  end
  
  def named_path
    rspec_on_rails_specs_path
  end
  
  def params_foo
    params[:foo]
  end
  
  def session_foo
    session[:foo]
  end
  
  def request_thing
    request.thing
  end
  
  def flash_thing
    flash[:thing]
  end
end
