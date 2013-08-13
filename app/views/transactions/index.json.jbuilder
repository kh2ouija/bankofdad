json.array!(@transactions) do |transaction|
  json.extract! transaction, :customer_id, :type, :amount, :description
  json.url transaction_url(transaction, format: :json)
end
