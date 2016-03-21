class CreateUsers < ActiveRecord::Migration
  def change
  	drop_table :users if ActiveRecord::Base.connection.table_exists? :users
    create_table :users do |t|
      t.string :email
      t.string :name
      t.boolean :activated
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
