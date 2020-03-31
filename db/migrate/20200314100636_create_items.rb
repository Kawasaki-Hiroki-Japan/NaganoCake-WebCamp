class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, nil: false, foreign_key: true
      t.string :name, null: false
      t.text :body
      t.integer :price, null: false
      t.string :image_id
      t.boolean :status, null: false, default: false
      t.timestamps
    end
    add_index :items, :name, unique: true
  end
end
