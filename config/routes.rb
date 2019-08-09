Rails.application.routes.draw do
  get 'homes/top'
  devise_for :users
  root 'homes#top'
  get 'users/show'
  get 'users/index'
  get 'photos/new'
  get 'photos/index'
  get 'photos/show'
  get 'photos/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
