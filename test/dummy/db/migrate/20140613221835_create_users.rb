class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.integer :age
      t.integer :phone

      t.timestamps null: false
    end
  end
end
