Rails.application.routes.draw do
  resources :data_sets do
    member do
      get 'map'
      get 'analyze'
    end
  end
  root 'public#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
