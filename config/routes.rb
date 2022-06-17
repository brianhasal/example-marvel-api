Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/characters" => "characters#index"

  get "/photos" => "characters#photos"
  get "/photos/by_id" => "characters#photos_by_id"

  get "/character_list/starts_with" => "characters#character_starts_with"

  get "/character_list" => "characters#character_list"

  get "/characters/:character_id" => "characters#character_by_id"

  get "/comics/cover_art/" => "comics#cover_art_by_issue_id"

  get "/stories/" => "stories#stories_by_stories_id"

  get "/marvel_link/" => "add_url_auths#"

end
