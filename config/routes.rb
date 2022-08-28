Rails.application.routes.draw do

  ## get 'homes/top'
  get '/about' => 'public/homes#about', as: 'about'
  root to: "public/homes#top"
  get '/admin' => 'admin/homes#top', as: 'top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]

  resources :items, only: [:index, :new, :create, :show, :edit, :update]

  resources :customers, only: [:index, :show, :edit, :update, :destroy]

  resources :orders, only: [:show, :update]

  resources :order_details, only: [:update]

end



##namespace :public do
##  resources :items, only: [:index, :show]
##end
##get '/items' => 'items#index', as: 'items'
##get '/items/:id' => 'items#show', as: 'items'



##namespace :public do
##  resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
##  get '/customers/my_page' => '/customer#show', as: 'customers'
##end

scope module: :public do
  get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'customers/unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw'
  get '/customers/my_page' => 'customers#show', as: 'customers/my_page'
  get '/customers/information/edit' => 'customers#edit', as: 'customers/information/edit'
  patch '/customers/information/edit' => 'customers#update'
  ##patch 'customers/:id' => 'customers#update'
  ## resources :customers, only: [:show, :edit, :update, :destroy]
  ##get '/customers/unsubscribe' =>

  patch '/addresses' => 'addresses#update'
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  resources :items, only: [:index, :new, :create, :show, :edit, :update]

  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :create, :update, :destroy]

  post 'orders/comfirm' => 'orders#comfirm'
  get 'orders/complete' => 'orders#complete'
  resources :orders, only: [:new, :create, :index, :show]

end

end
