class AddIndexToEventsExternalId < ActiveRecord::Migration[8.0]
  def change
    add_index :events, :external_id, unique: true
  end
end
