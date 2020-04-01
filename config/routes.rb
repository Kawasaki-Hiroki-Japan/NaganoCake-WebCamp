Rails.application.routes.draw do

  devise_for :end_users, skip: :all
  devise_scope :end_user do
    get 'end_users/sign_in' => 'end_users/sessions#new', as: 'new_end_user_session'
    post 'end_users/sign_in' => 'end_users/sessions#create', as: 'end_user_session'
    delete 'end_users/sign_out' => 'end_users/sessions#destroy', as: 'destroy_end_user_session'
    get 'end_users/sign_up' => 'end_users/registrations#new', as: 'new_end_user_registration'
    post 'end_users' => 'end_users/registrations#create', as: 'end_user_registration'
  end

  scope module: :public do
    get 'end_users' => 'end_users#show', as: 'end_user'
    get 'end_users/edit' => 'end_users#edit', as: 'edit_end_user'
    patch 'end_users' => 'end_users#update', as: 'update_end_user'
    get 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
    delete 'end_users' => 'end_users#destroy', as: 'destroy_end_user'
  end

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admin do
    get 'items' => 'items#index', as: 'items'
    get 'end_users' => 'end_users#index', as: 'end_users'
  end
end
