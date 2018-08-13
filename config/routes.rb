Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/ticket', :to => 'tickets#create' # 新增票券（for admin）
  get '/ticket/:code', :to => 'tickets#check' #查詢票券（for admin）
  post '/ticket/list', :to => 'tickets#list' #票券清單（for admin）
  put '/ticket/:code', :to => 'tickets#update' #修改票券（for admin）
  delete '/ticket/:code', :to => 'tickets#delete' #刪除票券（for admin）
  post '/member', :to => 'members#create' #新增會員（for both）
  put '/member/:token', :to => 'members#update' #修改會員資料（for both）
  get '/member/:token', :to => 'members#show' #查詢會員資料（for normal）
  delete '/member/:token', :to => 'members#destroy' #刪除會員（for both）
  post '/member/list/', :to => 'members#list' #會員清單（for admin）
  get '/member/checktickets/:token', :to => 'members#c_tickets' #會員查詢個人所有票券（for normal）
  #post 'member/singleticket/', :to => 'members#s_ticket'
  post '/member/login', :to => 'members#login' #會員登入
  post '/member/logout', :to => 'members#logout' #會員登出
  resources :categories
end
