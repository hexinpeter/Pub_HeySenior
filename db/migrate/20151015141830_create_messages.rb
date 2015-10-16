class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id, index: true
      t.integer :recipient_id, index: true
      t.text :content

      t.timestamps null: false
    end
  end
end
