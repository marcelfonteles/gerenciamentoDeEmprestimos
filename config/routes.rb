Rails.application.routes.draw do
  # devise_for :users
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do 
    #root 'users/sessions#new'
    root 'loans#index'
  end
  
  scope :loan do
    get 'index', to: 'loans#index'
    post 'createloan', to: 'loans#create', as: 'create_loan'
    post 'filtro', to:'loans#filtering', as: 'filtering_loan'
    get 'resultado/:date', to:'loans#filtered', as: 'filtered_loan'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
