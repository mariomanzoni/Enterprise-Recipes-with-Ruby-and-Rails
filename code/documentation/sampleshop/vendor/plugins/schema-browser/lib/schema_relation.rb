#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class SchemaRelation
  attr_reader :origin_table_id, :origin_row_id, :destination_table_id, :destination_row_id

  def initialize(oti, ori, dti, dri)
    @origin_table_id = oti
    @origin_row_id = ori
    @destination_table_id = dti
    @destination_row_id = dri
  end
end
