Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root to: 'monitor#index'
  get 'ping', to: 'monitor#ping'

  scope '/logistic' do
    resources :trip_kinds
    resources :trips
    resources :shifts
    resources :time_windows

  end
end
