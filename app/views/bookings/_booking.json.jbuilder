json.extract! booking, :id, :adventure_id, :adventure_title, :ticket_quantity, :adventure_date, :cost, :user_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
