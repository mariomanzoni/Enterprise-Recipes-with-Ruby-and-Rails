#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'schema_table'
require 'schema_column'
require 'schema_relation'

class SchemaBrowser
  attr_reader :tables, :relations

  def initialize
    @tables = SchemaBrowser.get_tables_from_connection.map do |table_name|
      SchemaTable.new(table_name)
    end
    @tables.each do |table|
      table.gather_relations
    end
  end

  def relations
    unless @relations
      @relations = []
      @tables.each do |table|
        @relations += table.relations
      end
    end
    @relations
  end

  protected

  def self.get_tables_from_connection
    tables = ActiveRecord::Base.connection.tables
    tables.delete("schema_info")
    tables.sort
  end
end
