# representation of a session on a Stock Exchange.
# it needs to be open and close at very specific time. It can be open only once and close once as well.
class StockSession < ActiveRecord::Base
  include EventSchedulable

  # schedule_events :open, :close

  def on_open
    update_attribute(:open, true)
    # enable transactions, etc.
  end

  def on_close
    update_attribute(:open, false)
    # reject pending transactions, block creation of new ones, etc.
  end
end

# == Schema Information
#
# Table name: stock_sessions
#
#  id         :integer          not null, primary key
#  open_at    :datetime
#  close_at   :datetime
#  open       :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

