require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was onl a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    col_values = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns =  col_values.first.map!(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col){ attributes[col]}
      define_method("#{col}="){|val| attributes[col] = val}
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.underscore.pluralize
  end

  def self.all
    a = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    self.parse_all(a)
  end

  def self.parse_all(results)
    # ...
    # p results => [{"id"=>1, "name"=>"Breakfast", "owner_id"=>1}, {"id"=>2, "name"=>"Earl", "owner_id"=>2}, {"id"=>3, "name"=>"Haskell", "owner_id"=>3}, {"id"=>4, "name"=>"Markov", "owner_id"=>3}, {"id"=>5, "name"=>"Stray Cat", "owner_id"=>nil}]
    # p self => cat
    result = []
    results.each do |hash|
      result << self.new(hash)
    end
    result
  end

  def self.find(id)
    # ...
    a = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    a.empty? ? nil : new(a.first)
  end

  def initialize(params = {})
    # ...
    params.each do |key, value|
      symbol = key.to_sym
      raise "unknown attribute '#{symbol}'" unless self.class.columns.include?(symbol)
      self.send("#{symbol}=", value)
    end

  end

  def attributes
    # ...
    @attributes ||= {}
    # self.columns.each do |col|
    #   @attributes[col] = self.col
    # end
    # @attributes
  end

  def attribute_values
    # ...
    self.class.columns.map{|ele| send(ele)}
  end

  def insert
    # ...
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(",")
    question_marks = (["?"]* columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT into
        #{self.class.table_name}(#{col_names})
      values
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id

  end

  def update
    # ...
    set_line = self.class.columns.map{|ele| "#{ele} = ?"}.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    # ...
    id.nil? ? insert : update
  end
end
