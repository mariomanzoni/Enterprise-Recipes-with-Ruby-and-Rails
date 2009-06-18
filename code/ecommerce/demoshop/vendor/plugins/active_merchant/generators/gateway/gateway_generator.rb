#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class GatewayGenerator < RubiGen::Base
  LIB_DIR = "lib/active_merchant/billing/gateways/"
  UNIT_TEST_DIR = "test/unit/gateways/"
  REMOTE_TEST_DIR =  "test/remote/gateways/"
  
  
  default_options :author => nil
  
  attr_reader :name
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.length < 1
    @name = args.shift
    extract_options
  end
  
  def class_name
    @name.classify
  end

  def manifest
    record do |m|
      
      m.directory LIB_DIR
      m.directory UNIT_TEST_DIR
      m.directory REMOTE_TEST_DIR

      m.template 'gateway.rb', LIB_DIR + "#{name}.rb"
      m.template 'gateway_test.rb', UNIT_TEST_DIR + "#{name}_test.rb"
      m.template 'remote_gateway_test.rb', REMOTE_TEST_DIR + "remote_#{name}_test.rb"
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