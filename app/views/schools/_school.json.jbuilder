json.extract! school, :id, :name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade, :active, :created_at, :updated_at
json.url school_url(school, format: :json)