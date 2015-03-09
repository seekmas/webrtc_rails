json.array!(@homes) do |home|
  json.extract! home, :id, :title, :user, :password, :description, :cover
  json.url home_url(home, format: :json)
end
