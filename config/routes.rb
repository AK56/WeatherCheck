Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'locations#lookup'
	resources :location, only: [:lookup]
	get '/search', to: 'locations#lookup'
end
