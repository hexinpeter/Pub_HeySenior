class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :school, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :city, index: true
      t.string :phone
      t.string :photo

      t.timestamps null: false
    end
  end
end
