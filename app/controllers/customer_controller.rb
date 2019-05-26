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
    @filter = filter(params[:id])
    @newLoan = Loan.new
    @p1 = Date.today + 70
    @p2 = Date.today + 100
    @p3 = Date.today + 130
  end

  def filtering
    redirect_to filtered_customer_loan_path(params[:customer_id], params[:date])
  end
  
  def filtered
    @mes = params[:date][0..1].to_i
    @ano = params[:date][3..7].to_i
    @customer_id = params[:customer_id]
    puts @customer_id
    @cliente = Customer.find(params[:customer_id])
    @filter = params[:date]
    @loans = Loan.select {|loan| loan.customer_id == @customer_id.to_i}
    puts @loans
    @loans = @loans.select {|loan| (loan.date_p1.month == params[:date][0..1].to_i and loan.date_p1.year == params[:date][3..7].to_i) or 
                                    (loan.date_p2.month == params[:date][0..1].to_i and loan.date_p2.year == params[:date][3..7].to_i) or 
                                    (loan.date_p3.month == params[:date][0..1].to_i and loan.date_p2.year == params[:date][3..7].to_i)
                              }

  end



  private

  def customer_params
  	params.require(:customer).permit(:name, :cpf, :address, :phone)
  end


  def filter(id)
    @loans = Customer.find(id).loans
    @monthArray = []
    @loans.each do |loan|
      if loan.date_p1.month.to_s.length == 1  
        @monthArray.push('0' + loan.date_p1.month.to_s + '/' + loan.date_p1.year.to_s) 
      else
        @monthArray.push(loan.date_p1.month.to_s + '/' + loan.date_p1.year.to_s) 
      end
      if loan.date_p2.month.to_s.length == 1  
        @monthArray.push('0' + loan.date_p2.month.to_s + '/' + loan.date_p2.year.to_s) 
      else
        @monthArray.push(loan.date_p2.month.to_s + '/' + loan.date_p2.year.to_s) 
      end
      if loan.date_p3.month.to_s.length == 1  
        @monthArray.push('0' + loan.date_p3.month.to_s + '/' + loan.date_p3.year.to_s) 
      else
        @monthArray.push(loan.date_p3.month.to_s + '/' + loan.date_p3.year.to_s) 
      end
    end
    return @monthArray.uniq
  end
end