class LoansController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @loans = Loan.all.order(:date_p1, :date_p2, :date_p3)
    @newLoan = Loan.new
    @p1 = Date.today + 30
    @p2 = Date.today + 60
    @p3 = Date.today + 90
    @loansFilter = loans_filter
  end
  
  def create
    @loan = Loan.new(loans_params)
    if @loan.save
      puts "Salvo com sucesso"
    else 
      flash[:notice] = "Não cadastrado."
    end
  end
  
  def filtering
    redirect_to filtered_loan_path(params[:date])
  end
  
  def filtered
    @loansFilter = loans_filter
    @loans = Loan.all.select {|loan| (loan.date_p1.month == params[:date][0..1].to_i and loan.date_p1.year == params[:date][3..7].to_i) or 
                                    (loan.date_p2.month == params[:date][0..1].to_i and loan.date_p2.month == params[:date][3..7].to_i) or 
                                    (loan.date_p3.month == params[:date][0..1].to_i and loan.date_p2.month == params[:date][3..7].to_i)
                              }
    puts @loans
    @newLoan = Loan.new
    @p1 = Date.today + 30
    @p2 = Date.today + 60
    @p3 = Date.today + 90
  end
  
  private
  
  def loans_params
    params.require(:loan).permit(:amount, :name, :store, :portion1, :portion2, :portion3, :date_p1, :date_p2, :date_p3, :date)
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
