Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/characters" => "characters#index"

  post "/photos" => "characters#photos"

  post "/character_list/starts_with" => "characters#character_starts_with"

  get "/character_list" => "characters#character_list"



end
