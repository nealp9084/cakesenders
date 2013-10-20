json.array!(@users) do |user|
  json.extract! user, :realname, :username, :password, :email, :customer_token, :twitter_id, :facebook_id
  json.url user_url(user, format: :json)
end
