json.array!(@allowances) do |allowance|
  json.extract! allowance, :customer_id, :interval, :amount
  json.url allowance_url(allowance, format: :json)
end
