json.array!(@goodies) do |goody|
  json.extract! goody, :name, :description, :price
  json.url goody_url(goody, format: :json)
end
