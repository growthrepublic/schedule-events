# Provides functionality of scheduled events for ActiveRecord objects.
# It allows defining custom events.
# Every event has to be related with a column whose name is automatically matched
# (based on convention: event_name + '_at'), but can be overriden like below:
# 
# schedule_events :start, stop: 'cancel_at'
# 
# Every object can have maximum one event of a given type during it's whole lifecycle
# (e.g. stock session can only be open once and closed once).
# Be aware there can be no relationship between events at all.
#
# Callbacks are performed at a time specified in a related columns,
# thus if someone updates theirs' values then the callbacks should be rescheduled. (unless have already been fired).
# Let's assume that noone will change e.g. open_at value if it is in the past.
# If a related column doesn't provide any value except nil then callback shouldn't be scheduled.
module EventSchedulable
  extend ActiveSupport::Concern

  # your code goes here
end
