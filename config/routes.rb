Rails.application.routes.draw do
  resources :photos, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  root 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
