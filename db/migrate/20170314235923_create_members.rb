class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :designation, index: true
      t.string :company
      t.integer :joined_year, index: true
      t.string :email, index: true
      t.string :phone
      t.string :city
      t.string :zipcode, index: true
      t.string :state
      t.string :source, index: true

      t.timestamps null:false
    end

    add_index :members, [:first_name, :last_name]
    add_index :members, [:city, :state]

    create_table :cpas do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company
      t.integer :joined_year, index: true
      t.string :phone
      t.string :street
      t.string :city
      t.string :zipcode, index: true
      t.string :state
      t.string :site
      t.string :source, index: true

      t.timestamps null:false
    end
    add_index :cpas, [:first_name, :last_name]
    add_index :cpas, [:city, :state]

  end
end
