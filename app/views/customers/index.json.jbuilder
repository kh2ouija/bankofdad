json.array!(@customers) do |customer|
  json.extract! customer, :name, :balance
  json.url customer_url(customer, format: :json)
end
