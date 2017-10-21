Rails.application.routes.draw do
  get '/', to: 'front_end#index'

  get '/api/chat', to: 'messaging#index'
  post '/api/chat', to: 'messaging#index'
end
