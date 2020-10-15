Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :accounts do
    get :balance
    post :deposit
    post :withdrawal
    post :transfer
  end
end
