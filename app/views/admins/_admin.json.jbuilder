json.extract! admin, :id, :email, :pass, :description, :created_at, :updated_at
json.url admin_url(admin, format: :json)
