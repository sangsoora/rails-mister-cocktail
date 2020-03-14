Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'
  resources :cocktails, except: %i[index new edit] do
    resources :doses, only: [:create]
    resources :reviews, only: [:create]
  end
  get '/search', to: 'cocktails#search', as: :search
  get '/search/:query', to: 'cocktails#search_index', as: :search_result
  resources :doses, only: [:destroy]
  resources :reviews, only: %i[edit update destroy]
end
