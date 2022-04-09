class RenameShortUrlToToken < ActiveRecord::Migration[6.1]
  def change
    rename_column :links, :short_url, :token
  end
end
