class CreateSlides < ActiveRecord::Migration[7.0]
  def change
    create_table :slides do |t|
      t.string :file_path
      t.integer :order
      t.references :pitch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
