class LoansController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @loans = Loan.all
    @newLoan = Loan.new
  end
  
  def create
    @loan = Loan.new(loans_params)
    if @loan.save
      puts "Salvo com sucesso"
    else 
      puts "batata"
    end
  end
  
  private
  
  def loans_params
    params.require(:loan).permit(:amount, :firstPayment, :name, :store, :qtyPortion)
  end
end
