json.extract! product, :id, :code, :name, :name_kana, :price, :purchase_cost, :created_at, :updated_at
json.url product_url(product, format: :json)
