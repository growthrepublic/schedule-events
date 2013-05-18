class FakeScheduled < FakeActiveRecord
  include EventSchedulable
end

class ActiveSupport::TestCase
  # checks whether event job for specified target (instance of ActiveRecord::Base) and type (event) has been enqueued.
  # if at is specified it also checks if the found job is scheduled at the specified time.
  def assert_enqueued_event(target, event, at = nil)
    # implement this
  end

  def refute_enqueued_event(target, event, at = nil)
    # implement this
  end

  # checks whether mapping event names to column names with time specified has been done properly.
  def assert_event_to_column_mapping(mapping, &block)
    # implement this
  end
end