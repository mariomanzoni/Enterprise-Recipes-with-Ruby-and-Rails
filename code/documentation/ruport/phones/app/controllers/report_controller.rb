#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class ReportController < ApplicationController
  def all_phones
    report = CellPhone.report_table( 
      :all,
      :only => %w(model weight),
      :include => {
        :manufacturer => { :only => %w(name) }
      },
      :transforms => lambda do |row|
        row['weight'] = '%.2f' % (row['weight'] * 0.035274)
      end,
      :order => 'model'
    ) 
    report.rename_columns( 
      'model'             => 'Model',
      'manufacturer.name' => 'Manufacturer',
      'weight'            => 'Weight (oz)'
    )
    report = Grouping(report, :by => 'Manufacturer') 
    respond_to do |format|
      format.csv  { 
        send_data report.to_csv, 
                  :type => 'text/csv',
                  :filename => 'all_phones.csv'
      }
      format.pdf  {
        send_data report.to_pdf,
                  :type => 'application/pdf',
                  :disposition => 'inline',
                  :filename => 'all_phones.pdf'
      }
      format.html { @report_table = report.to_html }
    end
  end
end

