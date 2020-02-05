Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'about', to: 'welcome#about'

  #root 'articles#index'
  resources :articles
  # get 'article', to: 'article#index'
  #get 'welcome/home', to: 'welcome#home'
  #get 'welcome/about', to: 'welcome#about'

end
