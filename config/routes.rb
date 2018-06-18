Rails.application.routes.draw do
	# devise_for :users
	devise_for :users, :controllers => { :omniauth_callbacks => "callbacks"}
	get 'home/index'
	root to: "home#index"
	get "/auth/:provider/callback", to: "omniauth_callbacks#create"
	# get 'auth/failure', to: redirect('/')
	# delete 'signout', to: 'sessions#destroy', as: 'signout'
	resources :home do
		collection do
		  get 'about_us'
		  get 'coming_soon'
		  get 'exchange'
		  get 'order_booking'
		  get 'currency_exchange'
		  post 'exchange_order'
		end
	end
	resources :currencies do
		collection do
			get 'top_currencies'
		end
	end
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end