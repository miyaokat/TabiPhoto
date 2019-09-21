# frozen_string_literal: true

Rails.application.routes.draw do
  resources :photos, only: %i[index show new create edit update destroy]
  resources :maps, only: [:index]

  get 'maps/show'
  get 'homes/top'
  get 'homes/about'
  get 'users/show'
  get 'users/index'
  get 'users/edit'
  patch 'users/update'
  devise_for :users
  root 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
