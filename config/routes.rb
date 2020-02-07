Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'about', to: 'welcome#about'

  #root 'articles#index'
  resources :articles

  # we want to create appath so that /signup will take the users
  # to the new action.  To create the rest, we can simply display
  # resources :users, but exclude the new action.   Or we can
  # handle the post request as shown below.
  # post 'users', to 'users#create'
  #
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # get 'article', to: 'article#index'
  #get 'welcome/home', to: 'welcome#home'
  #get 'welcome/about', to: 'welcome#about'

end
