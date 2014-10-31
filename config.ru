require 'bundler'
Bundler.require

ROOT_PATH = Dir.pwd

Dir[ROOT_PATH+"/models/*.rb"].each { |file| require file }

require './helpers/authentication_helper'

require './controllers/application_controller'

Dir[ROOT_PATH+"/controllers/*.rb"].each { |file| require file }



map('/users'){ run UsersController }
map('/sessions'){ run SessionsController }
map('/foods'){ run FoodsController }
map('/parties'){ run PartiesController }
map('/orders'){ run OrdersController }
map('/'){ run ApplicationController }