Rails.application.routes.draw do

  root to: "public/homes#top"
  get '/about' => 'public/homes#about'


  #顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
    resources :items, only: [:index, :show]

    get 'customers/my_page' => "customers#show"
    get 'customers/information/edit' => "customers#edit"
    patch 'customers/information' => "customers#update"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"

    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete "destroy_all" => "cart_items#destroy_all"
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "comfirm" => "orders#confirm"
        get 'complete' => 'orders#complete'
      end
    end

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end




  #管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  get 'admin' => 'admin/homes#top'

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update, :edit]

    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
