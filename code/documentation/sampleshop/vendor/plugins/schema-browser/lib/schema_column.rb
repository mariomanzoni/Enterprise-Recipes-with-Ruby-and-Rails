#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class SchemaColumn
  attr_reader :default, :name, :column_id
  attr_accessor :index, :foreign_key, :primary_key

  @@last_id = 0

  def initialize(ar_column)
    @name = ar_column.name
    @type = ar_column.type
    @default = ar_column.default
    @column_id = get_id
  end

  def title
    @name
  end

  def type
    @type.to_s.capitalize
  end

  def attributes
    attr = { "id" => @column_id.to_s }
    attr["fk"] = "fk" if @foreign_key
    attr["pk"] = "pk" if @primary_key
    attr["index"] = "index" if @index
    attr
  end

  protected

  def get_id
    @@last_id += 1
  end
end
