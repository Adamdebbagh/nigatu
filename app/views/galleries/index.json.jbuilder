json.array!(@galleries) do |gallery|
  json.extract! gallery, :id, :title, :description, :image_url, :target_data
  json.url gallery_url(gallery, format: :json)
end
