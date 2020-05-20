json.extract! novel_list, :id, :title, :created_at, :updated_at
json.url novel_list_url(novel_list, format: :json)
