json.extract! card, :id, :numero, :validade, :bandeira, :cvv, :titular, :customer_id, :created_at, :updated_at
json.url card_url(card, format: :json)
