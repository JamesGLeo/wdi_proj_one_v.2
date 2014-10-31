class FoodsController < ApplicationController
  ## GET   /foods  Display a list of food items available
  get '/foods' do
    @foods = Food.all
    erb :'foods/index'
  end

  ## GET   /foods/new  Display a form for a new food item
  get '/foods/new' do
    authenticate!
    erb :'foods/new'
  end

  ## POST  /foods  Creates a new food item
  post '/foods' do
    food = Food.create(params[:food])
    if food.valid?
      redirect "/foods/#{food.id}"
    else
      @errors = food.errors.full_messages
      erb :'foods/new'
    end
  end

  ## GET   /foods/:id  Display a single food item and a list of all the parties that included it
  get '/foods/:id' do
    @food = Food.find(params[:id])
    erb :'/foods/show'
  end

  ## GET   /foods/:id/edit   Display a form to edit a food item
  get '/foods/:id/edit' do
    authenticate!
    @food = Food.find(params[:id])
    erb :'/foods/edit'
  end

  ## PATCH   /foods/:id  Updates a food item
  patch '/foods/:id' do
    food = Food.find(params[:id])
    food.update(params[:food])
    redirect "/foods/#{food.id}"
  end

  ## DELETE  /foods/:id  Deletes a food item
  delete '/foods/:id' do
    food = Food.destroy(params[:id])
    redirect "/foods"
  end

end