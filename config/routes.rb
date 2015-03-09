Rails.application.routes.draw do
  devise_for :users
  resources :homes

  get '/:home_id/password_confirmation' => 'homes#password' , :as => :password_confirmation
  post '/:home_id/password_confirmation' => 'homes#password' , :as => :password_confirmation_post

  root 'homes#index'
end
