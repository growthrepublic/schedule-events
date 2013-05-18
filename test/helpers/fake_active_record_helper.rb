require 'active_model'

# Simple and incomplete implementation of sth like in-memory ActiveRecord to test concerns.
class FakeActiveRecord
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Dirty

  define_model_callbacks :create, :update
  cattr_accessor :instances

  def initialize(attributes = {})
    self.class.instances ||= {}
    attributes.each do |name, value|
      instance_variable_set("@#{name}", value)
    end
  end

  def self.create(attributes = {})
    new(attributes).tap do |record|
      record.save
    end
  end

  def self.find(id)
    instances[id]
  end

  def save
    if valid?
      if persisted?
        run_callbacks :update do; end
      else
        run_callbacks :create do
          @persisted = true
          self.class.instances[id] = self
        end
      end
    end

    valid?
  end

  def update_attribute(name, value)
    send("#{name}=", value)
    save
  end

  def persisted?
    @persisted
  end

  def id
    @id ||= rand(10_000) if persisted?
  end
end