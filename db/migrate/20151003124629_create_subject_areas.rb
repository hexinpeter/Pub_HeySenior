class CreateSubjectAreas < ActiveRecord::Migration
  def change
    create_table :subject_areas do |t|
      t.string :name
    end
  end
end
