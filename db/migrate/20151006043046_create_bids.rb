class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true
      t.references :task, index: true
      t.text :description
      t.string :status
      t.decimal :price

      t.timestamps null: false
    end
  end
end
