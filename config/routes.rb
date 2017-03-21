Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'home#index'
  get "/checkout" => 'home#checkout'

  post "/make_payment" => "home#charge"
  get '/unsubscribe' => "home#unsubscribe"
  post '/unsubscribe' => "home#process_unsubscribe"

end
