json.extract! task, :id, :title, :priority, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)
