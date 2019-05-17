json.extract! ord_detail, :id, :order_id, :product_id, :unit_price, :quantity, :price, :mainte_bool,:mainte_yearprice,:mainte,:created_at, :updated_at
json.url ord_detail_url(ord_detail, format: :json)
