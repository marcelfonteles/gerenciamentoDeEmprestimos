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
    get ':id/edit', to: 'loans#edit', as: 'edit_loan'
    patch 'update', to: 'loans#update', as:'update_loan'
    post 'createloan', to: 'loans#create', as: 'create_loan'
    post 'filtro', to:'loans#filtering', as: 'filtering_loan'
    get 'resultado/:date', to:'loans#filtered', as: 'filtered_loan'
    get ':id', to: 'loans#loan', as: 'loan'
    post ':id/:portion/confirm', to: 'loans#confirm_payment', as: 'confirm_payment'
    post ':id/:portion/cancel', to: 'loans#cancel_payment', as: 'cancel_payment'
    delete ':id/delete', to: 'loans#destroy_loan', as: 'destroy_loan'
    get 'angular/json', to: 'loans#json_loans'
    # AngularJS

  end

  scope :customer do 
    get 'index', to: 'customer#index'
    get ':id/edit', to: 'customer#edit', as: 'edit_customer'
    patch 'update', to:'customer#update', as: 'update_customer'
    delete ':id/destroy', to: 'customer#destroy', as: 'destroy_customer'
    post 'createcustomer', to:'customer#create', as: 'create_customer'
    get ':id', to: 'customer#show', as: 'show_customer'
    post 'filtro', to:'customer#filtering', as: 'filtering_customer_loan'
    get 'resultado/:customer_id/:date/', to:'customer#filtered', as: 'filtered_customer_loan'
    get 'resultado/:customer_id/:date/confirm', to: 'customer#confirm_payment', as: 'confirm_customer_payments'
    get 'resultado/:customer_id/:date/cancel', to: 'customer#cancel_payment', as: 'cancel_customer_payments'
    get 'angular/json', to: 'customer#json_customers'
    # AngularJS
    post 'api/createcustomer', to: 'customer#api_create_customer'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end