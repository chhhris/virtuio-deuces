class ChargesController < ApplicationController

	def new
		@amount
	end

	def create
		@amount = params[:amount].to_i

		invoice_id = params[:invoice].to_i
		@invoice = Invoice.find_by_id(invoice_id)
		@invoice[:date_paid] = Time.now.in_time_zone("Eastern Time (US & Canada)")
		@invoice.save

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => "#{params[:description]}",
	    :currency    => 'usd'
	  )

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end

end
