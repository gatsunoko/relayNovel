json.extract! novel, :id, :title, :text, :user_id, :created_at, :updated_at
json.url novel_url(novel, format: :json)
