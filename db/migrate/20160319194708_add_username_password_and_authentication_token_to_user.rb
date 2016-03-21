class AddUsernamePasswordAndAuthenticationTokenToUser < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string
  	add_column :users, :password, :string
  	add_column :users, :authentication_token, :string
  end
end
