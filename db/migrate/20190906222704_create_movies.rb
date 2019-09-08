class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false, default: ''
      t.string :text, null: false, default: ''
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :image_url, null: false, default: ''
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
