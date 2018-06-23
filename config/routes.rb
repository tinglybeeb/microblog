Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # going to the domain root URL will find the controller with prefix "Pages" and call its "home" action
  root to: 'pages#home'
  # for URL: root/pages/about, find the controller with prefix "Pages" and call its "about" action
  get 'pages/about', to: 'pages#about'
  # Gets resourceful routes (which map between HTTP verbs and URLs and controller actions)
  # By convention, each action also maps to particular CRUD operations in a database
  resources :articles
  
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  
  # Login routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
end
