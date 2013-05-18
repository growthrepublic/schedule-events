require 'test_helper'
require 'helpers/event_schedulable_helper'

class ScheduledModel < FakeScheduled
  attr_accessor :open_at, :close_at # Active Record takes care of that
  schedule_events :open, :close

  def on_open; end

  def on_close; end

  private

  def open_at_changed?
    true
  end

  def close_at_changed?
    true
  end
end

class EventSchedulableTest < ActiveSupport::TestCase
  def test_defining_events
    assert_event_to_column_mapping(close: "close_at", open: "run_at") do
      attr_accessor :run_at, :open_at
      schedule_events :close, open: "run_at"
    end

    assert_event_to_column_mapping(open: "run_at") do
      attr_accessor :run_at
      schedule_events open: "run_at"
    end

    assert_event_to_column_mapping(open: "open_at", close: "close_at") do
      attr_accessor :open_at, :close_at
      schedule_events :open, close: "close_at"
    end
  end

  def test_scheduling_jobs_after_create
    object = ScheduledModel.create(open_at: Time.now + 1.hour)
    # enqueues only when we can tell when it should be performed
    assert_enqueued_event(object, :open, object.open_at)
    refute_enqueued_event(object, :close)
  end

  def test_rescheduling_jobs_after_update
    object = ScheduledModel.create(open_at: Time.now + 1.hour)
    object.update_attribute(:open_at, Time.now + 2.hours)

    assert_enqueued_event(object, :open, object.open_at)
  end

  def test_removing_job_if_time_changed_to_nil
    object = ScheduledModel.create(open_at: Time.now + 1.hour)
    object.update_attribute(:open_at, nil)

    refute_enqueued_event(object, :open)
  end

  def test_running_callbacks
    ScheduledModel.any_instance.expects(:on_open)

    object = ScheduledModel.create(open_at: Time.now)
    process_background_jobs
  end
end
