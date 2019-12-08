json.extract! adventure, :id, :title, :description, :price, :image_url, :created_at, :updated_at
json.url adventure_url(adventure, format: :json)
