Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins

  namespace :admin do
    resources :customers
  end

  scope module: :customer do
    resources :orders
    post 'orders/confirm' => 'orders#confirm', as: :order_confirm
    get 'orders/complete' => 'orders#complete', as: :order_complete
  end
end
