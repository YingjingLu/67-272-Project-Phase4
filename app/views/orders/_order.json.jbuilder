json.extract! order, :id, :school_id, :user_id, :date, :grand_total, :payment_receipt, :created_at, :updated_at
json.url order_url(order, format: :json)