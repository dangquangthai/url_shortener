class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :short_url, null: false
      t.string :long_url, null: false
      t.integer :clicked_count, null: false, default: 0
      t.belongs_to :user

      t.timestamps
    end

    add_index :links, :short_url, unique: true
  end
end
