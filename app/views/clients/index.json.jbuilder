json.array!(@clients) do |client|
  json.extract! client, :name, :email, :user_id
  json.url client_url(client, format: :json)
end
