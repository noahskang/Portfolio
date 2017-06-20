require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    @class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    options[:foreign_key] ||= ("#{name}".singularize + "_id").to_sym
    options[:primary_key] ||= :id
    options[:class_name] ||= "#{name}".camelcase.singularize

    @foreign_key = options[:foreign_key]
    @primary_key = options[:primary_key]
    @class_name = options[:class_name]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    options[:foreign_key] ||= ("#{self_class_name}".downcase.singularize + "_id").to_sym
    options[:primary_key] ||= :id
    options[:class_name] ||= "#{name}".camelcase.singularize

    @foreign_key = options[:foreign_key]
    @primary_key = options[:primary_key]
    @class_name = options[:class_name]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    options = BelongsToOptions.new(name, options)

    define_method(name) do
      foreign_key = options.send()


    define_method(name) do
      name.model_class
    end

    @foreign_key = self.

    # define_method(options.foreign_key) do
    #   send(options.foreign_key)
    # end
  end

  def has_many(name, options = {})
    # ...
    options = HasManyOptions.new(name, model_class, options = {})
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
