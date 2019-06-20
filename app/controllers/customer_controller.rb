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

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:customer][:id])
    @customer.update(customer_params)
    redirect_to root_path
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
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
    @mes = params[:date][0..1]
    @ano = params[:date][3..7]
    @customer_id = params[:customer_id]
    @cliente = Customer.find(params[:customer_id])
    @filter = params[:date]
    # Retorna os emprestimos filtrados
    @loans = selecting_loans(params[:date], params[:customer_id])
  end

  def confirm_payment
    @loans = selecting_loans(params[:date], params[:customer_id])
    @loans.each do |loan|
      if loan.date_p1.month == params[:date][0..1].to_i and loan.date_p1.year == params[:date][3..7].to_i
        loan.update(paid_p1: true)
      end
      if loan.date_p2.month == params[:date][0..1].to_i and loan.date_p2.year == params[:date][3..7].to_i
        loan.update(paid_p2: true)
      end 
      if loan.date_p3.month == params[:date][0..1].to_i and loan.date_p3.year == params[:date][3..7].to_i
        loan.update(paid_p3: true)
      end        
    end
    redirect_to filtered_customer_loan_path(params[:customer_id], params[:date])
  end

  def cancel_payment
    @loans = selecting_loans(params[:date], params[:customer_id])
    @loans.each do |loan|
      if loan.date_p1.month == params[:date][0..1].to_i and loan.date_p1.year == params[:date][3..7].to_i
        loan.update(paid_p1: false)
      end
      if loan.date_p2.month == params[:date][0..1].to_i and loan.date_p2.year == params[:date][3..7].to_i
        loan.update(paid_p2: false)
      end 
      if loan.date_p3.month == params[:date][0..1].to_i and loan.date_p3.year == params[:date][3..7].to_i
        loan.update(paid_p3: false)
      end        
    end
    redirect_to filtered_customer_loan_path(params[:customer_id], params[:date])
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

  def selecting_loans(date, id)
    @loans = Loan.select {|loan| loan.customer_id == id.to_i}
    @loans = @loans.select {|loan| (loan.date_p1.month == date[0..1].to_i and loan.date_p1.year == date[3..7].to_i) or 
                                    (loan.date_p2.month == date[0..1].to_i and loan.date_p2.year == date[3..7].to_i) or 
                                    (loan.date_p3.month == date[0..1].to_i and loan.date_p2.year == date[3..7].to_i)
                              }

    return @loans
  end
end
