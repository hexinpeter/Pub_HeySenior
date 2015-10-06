class AddDocumentsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :documents, :json
  end
end
