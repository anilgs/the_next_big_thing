class CreateEntries < ActiveRecord::Migration
  def change
    create_table :news_signup_entries do |t|
      t.string :email
      t.integer :tries, default: 0

      t.timestamps
    end
  end
end
