class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: true
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
