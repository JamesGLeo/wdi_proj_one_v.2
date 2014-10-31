class ApplicationController < Sinatra::Base
  
  helpers Sinatra::AuthenticationHelper

  require File.expand_path(File.dirname(__FILE__) + '/../connection')

  set :views, File.expand_path('../../views',__FILE__)
  set :public_folder, File.expand_path('../../public',__FILE__)

  enable :sessions, :method_override

  get '/' do
    erb :'index'
  end


  not_found do
    status 404
    "Lamesauce"
  end


end