json.array!(@users) do |user|
  json.extract! user, :realname, :username, :password_hash, :email, :customer_token, :twitter_id, :facebook_id, :admin
  json.url user_url(user, format: :json)
end
