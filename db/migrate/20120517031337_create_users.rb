class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :apikey
      t.string :uid
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
