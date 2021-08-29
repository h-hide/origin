Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :memos do
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy, :edit, :update]
  end

  get "SparX" => "top#index"
  root "top#index"
end
