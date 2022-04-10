class MarkApiKeyAsRequired < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :api_key, :string, null: false
    add_index :users, :api_key, unique: true
  end
end
