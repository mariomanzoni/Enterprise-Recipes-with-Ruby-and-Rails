#!/usr/bin/env ruby
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---


require 'rexml/parsers/pullparser'

class CallDetailRecord
  CDR_DIR = File.join('data', 'cdr')
  attr_accessor :from, :to, :timestamp, :duration
  
  def initialize(from, to, timestamp, duration)
    @from, @to, @timestamp, @duration = from, to, timestamp, duration
  end

  def self.find_all(from, date = Time.now)
    input_file = CDR_DIR + '/' + date.strftime('%Y%m%d') + '.xml'
    parser = REXML::Parsers::PullParser.new(File.new(input_file)) 
    cdrs = []
    while parser.has_next? 
      event = parser.pull 
      if event.start_element? and event[0] == 'cdr' 
        attributes = event[1]  
        if attributes['from'] == from
          cdrs << CallDetailRecord.new(
            attributes['from'],
            attributes['to'],
            attributes['timestamp'],
            attributes['duration']
          )
        end
      end
    end
    cdrs
  end
end

