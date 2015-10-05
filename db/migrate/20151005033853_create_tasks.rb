class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true, foreign_key: true
      t.string :subject
      t.text :description
      t.decimal :upper_price
      t.decimal :lower_price
      t.string :location
      t.text :title
      t.string :status
      t.references :subject_area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
