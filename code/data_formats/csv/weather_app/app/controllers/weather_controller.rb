#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'fastercsv'

class WeatherController < ApplicationController
  def export
    output = FasterCSV.generate do |csv| 
      csv << %w(
        LOCATION DATE COND_DAY COND_NIGHT
        TEMP_MAX TEMP_MIN RAIN_PROBABILITY
      )
      WeatherInformation.find(:all).each do |wi| 
        csv << [
          wi.location, wi.date.strftime('%Y%M%d'), wi.cond_day,
          wi.cond_night, wi.temp_max, wi.temp_min,
          wi.rain_probability
        ]
      end
    end
    send_data( 
      output,
      :type => get_content_type(request.user_agent),
      :filename => "weather_#{Time.now.strftime('%Y%M%d')}.csv"
    )
  end
  
  private
  
  def get_content_type(user_agent)
    user_agent =~ /windows/i ? 'application/vnd.ms-excel' : 'text/csv'
  end
end



class WeatherController
  def import
    parser = FasterCSV.new( 
      params[:weather_data][:file_data],
      :headers => true,
      :header_converters => :symbol,
      :col_sep => ';'
    )    
    parser.convert do |field, info| 
      case info.header
        when :date
          Date.parse(field)
        when :rain_probability
          field.to_i
        when :temp_max, :temp_min
          field.to_f
        else
          field
      end
    end
    
    WeatherInformation.delete_all
    parser.each do |row| 
      WeatherInformation.create(row.to_hash) 
    end
  end
end

