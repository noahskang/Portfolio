json.poke do
  json.extract! @poke, :id, :name
  json.image_url asset_path(@poke.image_url)
end

json.items do
  json.array! @poke.items
end
