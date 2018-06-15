Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # going to the domain root URL will find the controller with prefix "Pages" and call its "home" action
  root to: 'pages#home'
  # for URL: root/pages/about, find the controller with prefix "Pages" and call its "about" action
  get 'pages/about', to: 'pages#about'
  
end
