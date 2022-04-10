class AddApiKeyToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :api_key, :string

    generate_api_key_for_existing_users
  end

  def generate_api_key_for_existing_users
    User.where(api_key: nil).find_each do |user|
      user.update(api_key: SecureRandom::base58(128))
    end
  end
end
