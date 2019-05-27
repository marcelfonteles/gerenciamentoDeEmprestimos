Rails.application.routes.draw do
  get 'customer/index'
  # devise_for :users
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do 
    #root 'users/sessions#new'
    root 'customer#index'
  end
  
  scope :loan do
    get 'index', to: 'loans#index'
    post 'createloan', to: 'loans#create', as: 'create_loan'
    post 'filtro', to:'loans#filtering', as: 'filtering_loan'
    get 'resultado/:date', to:'loans#filtered', as: 'filtered_loan'
    get ':id', to: 'loans#loan', as: 'loan'
    post ':id/:portion/confirm', to: 'loans#confirm_payment', as: 'confirm_payment'
    post ':id/:portion/cancel', to: 'loans#cancel_payment', as: 'cancel_payment'
    delete ':id/delete', to: 'loans#destroy_loan', as: 'destroy_loan'
  end

  scope :customer do 
    get 'index', to: 'customer#index'
    post 'createcustomer', to:'customer#create', as: 'create_customer'
    get ':id', to: 'customer#show', as: 'show_customer'
    post 'filtro', to:'customer#filtering', as: 'filtering_customer_loan'
    get 'resultado/:customer_id/:date/', to:'customer#filtered', as: 'filtered_customer_loan'
    get 'resultado/:customer_id/:date/confirm', to: 'customer#confirm_payment', as: 'confirm_customer_payments'
    get 'resultado/:customer_id/:date/cancel', to: 'customer#cancel_payment', as: 'cancel_customer_payments'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end