json.array!(@tasks) do |task|
  json.extract! task, :id, :user_id, :subject, :description, :upper_price, :lower_price, :location, :title, :status, :subject_area_id
  json.url task_url(task, format: :json)
end
