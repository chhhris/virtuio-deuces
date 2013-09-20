json.array!(@invoices) do |invoice|
  json.extract! invoice, :client_id, :user_id, :description, :amount, :date_paid, :date_due
  json.url invoice_url(invoice, format: :json)
end
