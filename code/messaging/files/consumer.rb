#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'ftools'
require 'logger'

class MessageConsumer
  attr_accessor :input_dir, :done_dir, :error_dir
  attr_accessor :sleep_interval, :filename_pattern
  
  def initialize
    @sleep_interval = 2
    @filename_pattern = '*.xml'
    @logger = Logger.new(STDOUT)
  end
  
  def start
    while true do
      files = Dir[File.join(@input_dir, @filename_pattern)] 
      files.each do |filename|
        begin
          new_filename = filename.sub(/\.xml$/, "-#{$$}.xml") 
          if File.move(filename, new_filename) 
            filename = new_filename
            if process(filename)
              File.move(filename, @done_dir)
            else
              File.move(filename, @error_dir)
            end
          end
        rescue Errno::ENOENT 
          @logger.info "Another process handles #{filename}."
        rescue => ex
          @logger.error "Error processing #{filename}: #{ex}"
          File.move(filename, @error_dir) if File.exist?(filename)
        end
      end
      sleep @sleep_interval
    end
  end
  
  def process(filename)
    message_id = File.basename(filename, '.xml')
    @logger.info "Processing #{message_id}."
    true
  end
end


# f.flock File::LOCK_EX | File::LOCK_NB
# f.flock File::LOCK_UN

if $0 == __FILE__
  
  receiver = MessageConsumer.new
  receiver.input_dir = 'data/in'
  receiver.done_dir = 'data/done'
  receiver.error_dir = 'data/err'
  receiver.start
  
end
