Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root to: 'monitor#index'
  get 'ping', to: 'monitor#ping'

  scope '/logistic' do
    resources :trip_kinds, only:[:create, :update, :destroy, :index, :show ]
    resources :trips, only:[:create, :update, :destroy, :index, :show ] do
      resources :addresses, only:[:create, :update, :destroy, :index, :show ]

    end
    resources :shifts, only:[:create, :update, :destroy, :index, :show ]
    resources :time_windows, only:[:create, :update, :destroy, :index, :show ]

  end
end
