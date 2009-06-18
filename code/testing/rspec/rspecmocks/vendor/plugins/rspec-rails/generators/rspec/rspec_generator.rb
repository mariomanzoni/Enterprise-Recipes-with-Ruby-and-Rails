#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rbconfig'

# This generator bootstraps a Rails project for use with RSpec
class RspecGenerator < Rails::Generator::Base
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  def initialize(runtime_args, runtime_options = {})
    Dir.mkdir('lib/tasks') unless File.directory?('lib/tasks')
    super
  end

  def manifest
    record do |m|
      script_options     = { :chmod => 0755, :shebang => options[:shebang] == DEFAULT_SHEBANG ? nil : options[:shebang] }

      m.file      'rspec.rake',                    'lib/tasks/rspec.rake'

      m.file      'script/autospec',               'script/autospec',    script_options
      m.file      'script/spec',                   'script/spec',        script_options
      m.file      'script/spec_server',            'script/spec_server', script_options

      m.directory 'spec'
      m.file      'rcov.opts',                     'spec/rcov.opts'
      m.file      'spec.opts',                     'spec/spec.opts'
      m.template  'spec_helper.rb',                'spec/spec_helper.rb'

      m.directory 'stories'
      m.file      'all_stories.rb',                'stories/all.rb'
      m.file      'stories_helper.rb',             'stories/helper.rb'
    end
  end

protected

  def banner
    "Usage: #{$0} rspec"
  end

end
