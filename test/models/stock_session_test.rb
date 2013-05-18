require 'test_helper'
require 'delorean'

class StockSessionTest < ActiveSupport::TestCase
  def setup
    @open_at = Time.now + 1.second
    @close_at = Time.now + 5.seconds
  end

  def teardown
    Delorean.back_to_the_present
  end

  def test_closed_after_creation
    session = StockSession.create(open_at: @open_at, close_at: @close_at)
    assert !session.reload.open?, "Session expected to be closed after creation."
  end

  def test_lifecycle
    session = StockSession.create(open_at: @open_at, close_at: @close_at)

    Delorean.time_travel_to(@open_at)
    process_background_jobs
    assert session.reload.open?, "Session expected to be open after open event."

    Delorean.time_travel_to(@close_at)
    process_background_jobs
    assert !session.reload.open?, "Session expected to be closed after close event."
  end
end
