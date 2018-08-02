Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/ticket', :to => 'tickets#create'
  get '/ticket/:code', :to => 'tickets#check'
  put '/ticket/:code', :to => 'tickets#update'
  delete '/ticket/:code', :to => 'tickets#delete'
end
