Rails.application.routes.draw do
  resources :data_sets do
    member do
      get 'map'
      get 'analyze'
    end
  end

  resources :classifications

  root 'data_sets#index'
end
