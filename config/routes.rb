Rails.application.routes.draw do

  devise_for :users
	resources :articles do
		resources :comments
	end

	get '/admin/comments', to: 'comments#all'
	get '/admin/comments/page/:page', to: 'comments#all'
	get '/api/comments', to: 'comments#api'
	get '/api/articles', to: 'articles#api'

	root 'articles#index'

end