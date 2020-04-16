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
    # public/end_users Controller
    get 'end_users' => 'end_users#show', as: 'end_user'
    get 'end_users/edit' => 'end_users#edit', as: 'edit_end_user'
    patch 'end_users' => 'end_users#update', as: 'update_end_user'
    get 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
    delete 'end_users' => 'end_users#destroy', as: 'destroy_end_user'

    # public/items Controller
    get 'end_users/items' => 'items#index', as: 'items'
    get 'end_users/items/:id' => 'items#show', as: 'item'

    # public/cart_items Controller
    get 'end_users/cart' => 'cart_items#index', as: 'cart'
    post 'end_users/items/:id' => 'cart_items#create', as: 'cart_add_item'
    patch 'end_users/cart/items/:id' => 'cart_items#update', as: 'cart_item'
    delete 'end_users/cart/items/:id' => 'cart_items#item_destroy', as: 'cart_delete_item'
    delete 'end_users/cart' => 'cart_items#destroy', as: 'cart_empty'

    # public/orders Controller
    get 'end_users/orders/new' => 'orders#new', as: 'new_order'
    post 'end_users/orders/new' => 'orders#create', as: 'create_order'
    get 'end_users/orders/verification' => 'orders#verification', as: 'verification_order'
    patch 'end_users/orders' => 'orders#complete', as: 'complete_order'
    delete 'end_users/orders' => 'orders#destroy', as: 'destroy_order'
    get 'end_users/orders/done' => 'orders#done', as: 'done_order'
  end

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admin do
    get 'items' => 'items#index', as: 'items'
    get 'items/new' => 'items#new', as: 'new_item'
    post 'items' => 'items#create', as: 'create_item'
    get 'end_users' => 'end_users#index', as: 'end_users'
    get 'orders' => 'orders#index', as: 'orders'
    get 'orders/:id' => 'orders#show', as: 'order'
    patch 'orders/:id' => 'orders#update', as: 'update_order'
    patch 'orders/items/:id' => 'orders#item_update', as: 'update_order_item'
  end
end
