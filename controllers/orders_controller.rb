class OrdersController < ApplicationController
  ## POST  /orders   Creates a new order
  post '/orders' do
    authenticate!
    foods =  params['food'].keys.map{ |id| Food.find(id) }
    party = Party.find(params[:party][:party_id])
    foods.each do |food|
      party.foods << food
    end
   redirect "/parties/#{party.id}"
  end

  # PATCH   /orders/:id   Change item to no-charge  
  patch '/orders/:id' do
    order = Order.find(params[:id])
    order.update(params[:order])
    redirect "/parties/#{party.id}"
  end

  ## DELETE  /orders   Removes an order
  delete '/orders/:id' do
    old_order = Order.destroy(params[:order][:id])
    redirect "/parties/#{old_order.party.id}"
  end

end