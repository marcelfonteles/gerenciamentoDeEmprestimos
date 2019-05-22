class LoansController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @loans = Loan.all
    @newLoan = Loan.new
    @p1 = Date.today + 30
    @p2 = Date.today + 60
    @p3 = Date.today + 90
  end
  
  def create
    @loan = Loan.new(loans_params)
    if @loan.save
      puts "Salvo com sucesso"
    else 
      flash[:notice] = "Não cadastrado."
    end
  end
  
  private
  
  def loans_params
    params.require(:loan).permit(:amount, :name, :store, :portion1, :portion2, :portion3, :date_p1, :date_p2, :date_p3)
  end
end
