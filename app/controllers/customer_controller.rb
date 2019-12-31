class CustomerController < ApplicationController
  before_action :authenticate_user!
  def index
  	@customer = Customer.all.order(:name)
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
    # 01/2020
    # 01234567
    @mes = params[:date][0..1]
    @ano = params[:date][3..6]
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

  # AngularJS
  def json_customers
    @customers = Customer.all.order(:name)
    render json:{status: 200, data: @customers}
  end

  def api_create_customer
    @customer = Customer.new
    @customer.name = params[:name]
    @customer.cpf = params[:cpf]
    @customer.address = params[:address]
    @customer.phone = params[:phone]
    if @customer.save
      render json: {status: 200, data: @customer.id}
    end
  end

  def api_update_customer
    @customer = Customer.find(params[:id])
    @customer.name = params[:name]
    @customer.cpf = params[:cpf]
    @customer.address = params[:address]
    @customer.phone = params[:phone]
    @customer.save
  end

  def api_get_customer
    @customer = Customer.find(params[:id])
    render json: {status: 200, data: @customer}
  end

  def api_filter
    @filter = filter(params[:id])
    render json: { status: 200, data: @filter}
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
    # 01/2020
    # 0123456
    @monthArrayUniq = @monthArray.uniq

    return @monthArrayUniq.sort { |a,b| Date.new(b[3..6].to_i, b[0..1].to_i, 01) <=> Date.new(a[3..6].to_i, a[0..1].to_i, 01)}
  end

  def selecting_loans(date, id)
    @loans = Loan.select {|loan| loan.customer_id == id.to_i}
    @loans = @loans.select {|loan| (loan.date_p1.month == date[0..1].to_i and loan.date_p1.year == date[3..7].to_i) or 
                                    (loan.date_p2.month == date[0..1].to_i and loan.date_p2.year == date[3..7].to_i) or 
                                    (loan.date_p3.month == date[0..1].to_i and loan.date_p3.year == date[3..7].to_i)
                              }

    return @loans
  end
end


ap Loan.where("date_p1 > ? or date_p2 > ? or date_p3 > ?", '2020-05-01', '2020-05-01', '2020-05-01')