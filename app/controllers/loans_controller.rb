class LoansController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @loans = Loan.all.order(:date_p1, :date_p2, :date_p3)
    @newLoan = Loan.new
    @p1 = Date.today + 70
    @p2 = Date.today + 100
    @p3 = Date.today + 130
    @loansFilter = loans_filter
  end
  
  def create
    @loan = Loan.new(loans_params)
    if @loan.save
      puts "Salvo com sucesso"
      redirect_to show_customer_path(params[:loan][:customer_id])
    else 
      flash[:notice] = "Não cadastrado."
      redirect_to show_customer_path(params[:loan][:customer_id])
    end
  end

  def edit
    @loan = Loan.find(params[:id])
    @customer_id = Customer.find(@loan.customer_id).id
  end

  def update
    @loan = Loan.find(params[:loan][:id])
    @loan.update(loans_params)
    redirect_to show_customer_path(params[:loan][:customer_id])
  end
  
  def loan 
    @loan = Loan.find(params[:id])
  end
  
  def confirm_payment
    @loan = Loan.find(params[:id])
    if params[:portion].to_i == 1
      @loan.update(paid_p1: true)
      flash[:notice] = "Pagamento confirmado da 1ª parcela"
    elsif  params[:portion].to_i == 2
      @loan.update(paid_p2: true)
      flash[:notice] = "Pagamento confirmado da 2ª parcela"
    elsif params[:portion].to_i == 3
      @loan.update(paid_p3: true)
      flash[:notice] = "Pagamento confirmado da 3ª parcela"
    end
    redirect_to loan_path(params[:id])
  end
  
  def cancel_payment
    @loan = Loan.find(params[:id])
    if params[:portion].to_i == 1
      @loan.update(paid_p1: false)
      flash[:notice] = "Pagamento da 1ª parcela cancelado"
    elsif  params[:portion].to_i == 2
      @loan.update(paid_p2: false)
      flash[:notice] = "Pagamento da 2ª parcela cancelado"
    elsif params[:portion].to_i == 3
      @loan.update(paid_p3: false)
      flash[:notice] = "Pagamento da 3ª parcela cancelado"
    end
    redirect_to loan_path(params[:id])
  end
  
  def filtering
    redirect_to filtered_loan_path(params[:date])
  end
  
  def filtered
    @loansFilter = loans_filter
    @filter = params[:date]
    @loans = Loan.all.select {|loan| (loan.date_p1.month == params[:date][0..1].to_i and loan.date_p1.year == params[:date][3..7].to_i) or 
                                    (loan.date_p2.month == params[:date][0..1].to_i and loan.date_p2.year == params[:date][3..7].to_i) or 
                                    (loan.date_p3.month == params[:date][0..1].to_i and loan.date_p2.year == params[:date][3..7].to_i)
                              }
    @newLoan = Loan.new
    @p1 = Date.today + 30
    @p2 = Date.today + 60
    @p3 = Date.today + 90
  end
  
  def destroy_loan
    @loan = Loan.find(params[:id])
    @customer_id = @loan.customer_id
    if @loan.destroy
      redirect_to show_customer_path(@customer_id)
    end
  end

  # AngularJS
  def json_loans
    @loans = Loan.all
    render json: {status: 200, data: @loans}
  end

  def api_get_customer_loans
    @loans = Loan.all.where(customer_id: params[:id])
    render json: {status: 200, data: @loans}
  end

  def api_get_dates
    @p1 = Date.today + 70
    @p2 = Date.today + 100
    @p3 = Date.today + 130
    render json: { status: 200, data: {date_p1: @p1, date_p2: @p2, date_p3: @p3}}
  end

  def api_update_dates
    @p1 = Date.parse(params[:date_p1])
    @p2 = @p1 + 30
    @p3 = @p1 + 60
    render json: { status: 200, data: {date_p1: @p1, date_p2: @p2, date_p3: @p3}}
  end

  def api_new_loan
    puts params
    @loan = Loan.new
    @loan.store = params[:store]
    @loan.amount = params[:amount]
    @loan.portion1 = params[:portion1]
    @loan.portion2 = params[:portion2]
    @loan.portion3 = params[:portion3]
    @loan.date_p1 = params[:date_p1]
    @loan.date_p2 = params[:date_p2]
    @loan.date_p3 = params[:date_p3]
    @loan.paid_p1 = false
    @loan.paid_p2 = false
    @loan.paid_p3 = false
    @loan.customer_id = params[:customer_id]
    @loan.save
    render json: {status: 200, loanId: @loan.id}
  end

  def api_edit_loan
    @loan = Loan.find(params[:id])
    @loan.store = params[:store]
    @loan.amount = params[:amount]
    @loan.portion1 = params[:portion1]
    @loan.portion2 = params[:portion2]
    @loan.portion3 = params[:portion3]
    @loan.date_p1 = params[:date_p1]
    @loan.date_p2 = params[:date_p2]
    @loan.date_p3 = params[:date_p3]
    @loan.paid_p1 = false
    @loan.paid_p2 = false
    @loan.paid_p3 = false
    @loan.customer_id = params[:customer_id]
    @loan.save
    render json: {status: 200}
  end
  
  private
  
  def loans_params
    params.require(:loan).permit(:customer_id, :amount, :store, :portion1, :portion2, :portion3, :date_p1, :date_p2, :date_p3)
  end
  
  def loans_filter
    @loansYears = []
    Loan.all.each do |loan|
      @loansYears.push(loan.date_p1.year)
      @loansYears.push(loan.date_p2.year)
      @loansYears.push(loan.date_p3.year)
    end
    @loansYears = @loansYears.sort.uniq
    @loansFilter = []
    for i in 0..(@loansYears.length - 1)
      count = 1
      12.times do
        if count < 10
          @loansFilter.push("0#{count}/#{@loansYears[i]}")
        else
          @loansFilter.push("#{count}/#{@loansYears[i]}")
        end
        count += 1
      end
    end
    @loansFilter
  end
end
