#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class TracerGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      path = 'app/controllers'
      m.directory path
      m.template 'controller.rb', File.join(path, "#{file_name}_controller.rb")

      path = 'app/processors'
      m.directory path
      m.template 'trace_processor.rb', File.join(path, "#{file_name}_processor.rb")

      path = 'app/helpers'
      m.directory path
      m.template 'helper.rb', File.join(path, "#{file_name}_helper.rb")

      path = 'app/views/layouts'
      m.directory path
      m.file 'layout.rhtml', File.join(path, "#{file_name}.rhtml")

      path = "app/views/#{file_name}"
      m.directory path
      m.file 'index.rhtml', File.join(path, "index.rhtml")
    end
  end
end
