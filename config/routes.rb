Rails.application.routes.draw do

  devise_for :end_users, controllers: {
    sessions:      'end_users/sessions',
    passwords:     'end_users/passwords',
    registrations: 'end_users/registrations'
  }
  scope module: :public do
    get 'end_users/:id' => 'end_users#show', as: 'end_user'
  end

  devise_for :admin, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  namespace :admin do
    get 'items' => 'items#index', as: 'items'
  end
end
