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
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
