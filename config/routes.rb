Screwwashington::Application.routes.draw do

  root :to => 'main#index'
  
  match 'all' => "main#all"
  match 'about' => "main#about"

  match 'home' => 'users#index'
  match 'whois' => "users#whois", :via => [:post]

  match "new" => "screwconnectors#create"
  match "delete" => "screwconnectors#destroy"
  match 'match/:id' => 'screwconnectors#show'
  match 'sc/info' => 'screwconnectors#info', :via => [:post]

  match 'request' => "requests#create", :via => [:post]
  match 'request/deny' => "requests#deny", :via => [:post]
  match 'request/accept' => "requests#accept", :via => [:post]
  match 'request/delete' => "requests#delete", :via => [:post]

  match 'screws' => "main#index"
  match 'requests' => "main#index"

end
