Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :accounts do
    get '/', to: 'accounts#index', as: '/'
    get ':id/balance', to: 'accounts#balance', as: 'balance'
    get ':id/bonus_balance', to: 'accounts#bonus_balance', as: 'bonus_balance'
    post ':id/deposit', to: 'accounts#deposit', as: 'deposit'
    post ':id/withdraw', to: 'accounts#withdraw', as: 'withdraw'
    post ':id/transfer', to: 'accounts#transfer', as: 'transfer'
  end
end
