class SessionsController < ApplicationController

  get '/login' do
    erb :'sessions/login'
  end

  post '/' do
    user = User.find_by({username: params[:username]})
    if user && user.password == params[:password]
      session[:current_user] = user.id
      redirect '/users'
    else
      redirect '/sessions/login'
    end
  end

  delete '/' do
    session[:current_user] = nil
    redirect '/'
  end
  
end 