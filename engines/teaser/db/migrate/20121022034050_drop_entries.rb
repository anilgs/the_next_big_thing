class DropEntries < ActiveRecord::Migration
  def up
    drop_table :teaser_entries
  end
end
