Rails.application.routes.draw do
  get '/send', to: 'twilio#new', as: :new_twilio_send
  post '/send', to: 'twilio#create', as: :twilio_send
  root to: 'giphy#index'
end
