class CreateStockSessions < ActiveRecord::Migration
  def change
    create_table :stock_sessions do |t|
      t.datetime :open_at
      t.datetime :close_at
      t.boolean :open, default: false

      t.timestamps
    end
  end
end
