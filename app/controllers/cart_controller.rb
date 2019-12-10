class CartController < ApplicationController
  include Date_Extension
  
  def add

    id = params[:id]
    
    if session[:cart]
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    
    if cart[id]
      cart[id]["ticketQuantity"] += 1
    else
      dateToday = Date.today
      
      @dateOfNextSaturday = getNextSaturday(dateToday)
      @dateOfNextSunday = getNextSunday(dateToday)
      cart[id] = {"ticketQuantity" => 1, "adventureDate" => @dateOfNextSaturday}
    end
      
    if user_signed_in? 
      redirect_to :action=> :index
    else
      flash[:notice] = "Sign in first to start booking adventures!"
      redirect_to '/users/sign_in'
    end
  end
  
  def index
    if session[:cart]
      @cart = session[:cart]
    else
      @cart ={}
    end
    
    dateToday = Date.today
    
    @dateOfNextSaturday = getNextSaturday(dateToday)
    @dateOfNextSunday = getNextSunday(dateToday)
  end
  
  def remove
    id = params[:id]
    
    cart = session[:cart]
    
    cart.delete(id)
    
    redirect_to :action=> :index
  end
  
  def decrease
    id = params[:id]
    cart = session[:cart]
    
    if cart[id]["ticketQuantity"] == 1
      cart.delete(id)
    else
      cart[id]["ticketQuantity"] = cart[id]["ticketQuantity"] - 1
    end
    
    redirect_to :action=> :index
  end
  
  def increase
    id = params[:id]
    cart = session[:cart]
    
    if cart[id]
      cart[id]["ticketQuantity"] = cart[id]["ticketQuantity"] + 1
    else
      cart[id] = {"ticketQuantity" => 1}
    end
    
    redirect_to :action=> :index
  end
  
  def cancel
    session[:cart] = {}
    redirect_to '/adventures'
  end
  
  def createBooking
    @cart = session[:cart] || {}
    
    @cart.each do |adventureId, quantityAndDate|
      adventure = Adventure.find_by_id(adventureId)
      @user = User.find(current_user.id)
      @bookings = @user.bookings.build(
        :adventure_id => current_user.id.to_i + adventureId.to_i + DateTime.now.to_i, 
        :adventure_date => quantityAndDate["adventureDate"],
        :adventure_title => adventure.title,
        :ticket_quantity => quantityAndDate["ticketQuantity"],
        :cost => quantityAndDate["ticketQuantity"] * adventure.price)
        
      @bookings.save
    end
    
    session[:cart] = {}
    
    redirect_to '/bookings'
  end
  
  def dateOfNextAdventures(dateToday)
    
    @dateOfNextSaturday = dateToday + ((6 - dateToday.wday) % 7)
    @dateOfNextSunday = dateToday + ((7 - dateToday.wday) % 7)

  end
  
  def updateItemDate
    itemId = params[:id]
    itemNewDate = params[:d]
    
    puts itemId
    puts itemNewDate
    cart = session[:cart]
    
    itemInfo = cart[itemId]
    itemInfo["adventureDate"] = itemNewDate
    
    redirect_to :action=> :index
  end
  
end

