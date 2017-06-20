require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    # p params
    search_line = params.keys.map{|key| "#{key} = ?"}.join(" AND ")
    # p search_line

    a = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{search_line}
    SQL

    self.parse_all(a)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
