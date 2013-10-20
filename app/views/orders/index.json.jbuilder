json.array!(@orders) do |order|
  json.extract! order, :user_id, :goodie_id, :destination, :charge_token
  json.url order_url(order, format: :json)
end
