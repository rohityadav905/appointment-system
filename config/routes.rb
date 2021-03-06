Rails.application.routes.draw do
  devise_for :users
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
	  resources :users, only: [:index] do
	    collection do
	     
	      post :signin
	      post :signup
	      get  :signout
	     
	    end
	  end
	  resources :appointments
	end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
