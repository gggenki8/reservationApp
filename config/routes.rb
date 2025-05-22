Rails.application.routes.draw do
  get 'rooms/index'
  get 'users/show'
  get 'home/index'
  root "home#index"

  devise_for :users

  #ユーザーのマイページ表示用ルート
  resources :users, only: [:index, :show] do
    member do
      get :profile
      get :edit_account
      patch :update_account
      get :edit_profile
      patch :update_profile
      get :my_rooms
    end
  end
  #投稿された一覧表示用ルート
  resources :rooms do
    resources :reservations, only: [:index, :new, :create, :show, :destroy]
    collection do
      get :search
    end
  end
  #予約の一覧表示用ルート
  resources :reservations, only: [:index]

end
