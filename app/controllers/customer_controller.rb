class CustomerController < ApplicationController
  before_action :authenticate_user!
  def index
  	@customer = Customer.all
    @newCustomer = Customer.new
    @p1 = Date.today + 70
    @p2 = Date.today + 100
    @p3 = Date.today + 130
  end

  def create
  	@customer = Customer.new(customer_params)
  	@customer.save
    redirect_to root_path
  end

  def show
  	@customer = Customer.find(params[:id])
    @newLoan = Loan.new
    @p1 = Date.today + 70
    @p2 = Date.today + 100
    @p3 = Date.today + 130
  end
  private

  def customer_params
  	params.require(:customer).permit(:name, :cpf, :address, :phone)
  end
end
