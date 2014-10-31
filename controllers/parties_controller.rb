class PartiesController < ApplicationController
  ## GET   /parties  Display a list of all parties
  get '/parties' do
    @parties = Party.all
    erb :'/parties/index'
  end

  ## GET   /parties/new  Display a form for a new party
  get '/parties/new' do
    erb :'parties/new'
  end

  ## POST  /parties  Creates a new party
  post '/parties' do
    party = Party.create(params[:party])
    redirect "/parties/#{party.id}"
  end

  ## GET   /parties/:id  Display a single party and options for adding a food item to the party
  get '/parties/:id' do
    @party = Party.find(params[:id])
    # @party.foods shows all food items ordered by a party 
    @foods = Food.all
    erb :'/parties/show'
  end

  ## GET   /parties/:id/edit   Display a form for to edit a party's details
  get '/parties/:id/edit' do
    @party = Party.find(params[:id])
    erb :'/parties/edit'
  end

  ## PATCH   /parties/:id  Updates a party's details
  patch '/parties/:id' do
    party = Party.find(params[:id])
    party.update(params[:party])
    redirect "/parties/#{party.id}"
  end

  ## DELETE  /parties/:id  Delete a party
  delete '/parties/:id' do
    party = Party.delete(params[:id])
    redirect "/parties"
  end 

## GET   /parties/:id/receipt  Saves the party's receipt data to a file. 
##Displays the content of the receipt. 
#Offer the file for download.
get '/parties/:id/receipt' do
  @last_receipt = File.read('active_receipt.txt')
  erb :index
end

post 'parties/:id/receipts' do
  @party = Party.find(params[:id])
  food_costs = params[:order].values[1].map! { |cost| cost.to_f }
  food_dishnames = params[:order].values[0]
  receipt_items = food_costs.zip(food_dishnames) 

  receipt_file = File.open('active_receipt.txt', 'w')
  receipt_file.write("   Thanks for Dining with Us!\n")
  receipt_file.write("We Hope You've Enjoyed Your Meal\n")
  receipt_file.write("\n\n")
  receipt_file.write("            RECEIPT\n")
  receipt_file.write("--------------------------------\n")

  receipt_items.each do |item|
    receipt_file.write("$#{ item.join('              ') }\n")
  end
  receipt_file.write("\nGrand Total:\n")
  receipt_file.write("$#{ food_costs.inject{|sum,x| sum + x } }\n")
  receipt_file.write("\nSuggested Gratuity:\n")
  receipt_file.write("15% - $#{ food_costs.inject{|sum,x| sum + x } * 0.15 }\n")
  receipt_file.write("20% - $#{ food_costs.inject{|sum,x| sum + x } * 0.20 }\n")
  receipt_file.write("25% - $#{ food_costs.inject{|sum,x| sum + x } * 0.25 }\n")

  receipt_file.write("\nThank you for your Business!\n")
  receipt_file.close

  redirect "/parties"
end

# PATCH   /parties/:id/checkout   Marks the party as paid 
patch '/parties/:id/checkout' do
  @party = Party.find(params[:id])
  @party.update('paid_check' => true)
  redirect "/parties/#{@party.id}"
end


end