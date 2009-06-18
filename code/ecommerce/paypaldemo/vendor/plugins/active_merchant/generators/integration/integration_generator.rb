#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class IntegrationGenerator < RubiGen::Base
  BASE_DIR = "lib/active_merchant/billing/integrations/"
  TEST_DIR = "test/unit/integrations/"
  
  default_options :author => nil
  
  attr_reader :name
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.size < 1
    @name = args.shift
    extract_options
  end
  
  def class_name
    name.classify
  end
  
  def lib_dir
    BASE_DIR + name
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory lib_dir
      m.directory TEST_DIR
      m.directory TEST_DIR + "helpers"
      m.directory TEST_DIR + "notifications"
      
      m.template 'integration.rb', "#{lib_dir}.rb"
      m.template 'helper.rb', lib_dir + "/helper.rb"      
      m.template 'notification.rb', lib_dir + "/notification.rb"
     
      m.template 'module_test.rb', TEST_DIR + "#{name}_module_test.rb"
      m.template 'helper_test.rb', TEST_DIR + "helpers/#{name}_helper_test.rb"
      m.template 'notification_test.rb', TEST_DIR + "notifications/#{name}_notification_test.rb"
    end
  end

  protected
    def banner
      <<-EOS
Creates a ...

USAGE: #{$0} #{spec.name} name"
EOS
    end

    def add_options!(opts)
      # opts.separator ''
      # opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |options[:author]| }
      # opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end
    
    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end
end