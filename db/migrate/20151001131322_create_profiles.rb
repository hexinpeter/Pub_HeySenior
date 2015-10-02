class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :school, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :phone

      t.timestamps null: false
    end
  end
end
