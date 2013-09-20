class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.where(:user_id => current_user.id)
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @amount = @invoice.amount
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @user = current_user    
    @clients = @user.clients
  end

  # GET /invoices/1/edit
  def edit
    @user = current_user    
    @clients = @user.clients
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @user = current_user    
    @clients = @user.clients
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render action: 'show', status: :created, location: @invoice }
      else
        format.html { render action: 'new' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end

  def send_to_client
    @user = current_user
    @invoice = Invoice.find_by_id(params[:invoice_id])
    @client = @invoice.client
    UserMailer.invoice_email(@user, @invoice).deliver
    redirect_to @invoice, notice: "Invoice successfully sent to #{@client.name}. A copy was also sent to your email address at #{@user.email}."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:client_id, :user_id, :description, :amount, :date_paid, :date_due)
    end
end
