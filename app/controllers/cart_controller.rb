class CartController < ApplicationController
  #Prevents InvalidAuthenticityToken Error caused by using the PUT HTTP method
  #when calling updateItemDate. This error was happening because
  #the authenticity token became stale due to page caching. This disables
  #forgery protection for this controller to avoid this error.
  #Reference for this knowledge:
  #Title: Need help fixing an ActionController::InvalidAuthenticityToken error?
  #Author: AppSignal
  #Year: 2019
  #Availability: https://appsignal.com/for/invalid_authenticity_token#solution
  skip_before_action :verify_authenticity_token
  
  #Making the getNextSunday and getNextSaturday methods in the Date_extension
  #module available for use to the cart controller.
  include Date_Extension
  
  #This is triggered from the adventures view and adds a ticket for an 
  #adventure to the cart.
  def add

    #Gets the id of the particular adventure being added to the cart.
    id = params[:id]
    
    #Gets the cart hash from session and initialises it to an empty hash
    #if it doesn't already exist.
    if session[:cart]
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    
    #If the nested hash for an adventures ticket count and date already exists
    #in the cart hash, the adventure's ticket count is increased by 1.
    if cart[id]
      cart[id]["ticketQuantity"] += 1
    else
      #If the adventure was not yet added to the cart, we create a new nested hash
      #for the adventure in the cart hash. The ticket count is given a default
      #quantity of 1 and a default date of the next saturday.
      dateToday = Date.today
      
      @dateOfNextSaturday = getNextSaturday(dateToday)
      @dateOfNextSunday = getNextSunday(dateToday)
      cart[id] = {"ticketQuantity" => 1, "adventureDate" => @dateOfNextSaturday}
    end
      
    #Redirecting the user to the sign in/sign up page if they are not signed in.
    #Otherwise they are just taken to the index page of cart, which is the same
    #current page.
    if user_signed_in? 
      redirect_to :action=> :index
    else
      flash[:notice] = "Sign in first to start booking adventures!"
      redirect_to '/users/sign_in'
    end
  end
  
  #This gets the booking cart items and initialises potential adventure dates.
  def index
    #Getting the bookings cart for the view to use to display cart items to the 
    #user. Cart is initialised to empty if it is not found in session.
    if session[:cart]
      @cart = session[:cart]
    else
      @cart ={}
    end
    
    #Getting todays date as it is needed as an argument for the methods
    #calculating potential adventure dates.
    dateToday = Date.today
    
    #Getting the next saturday and sunday date so these can be displayed to the
    #user as potential adventure dates.
    @dateOfNextSaturday = getNextSaturday(dateToday)
    @dateOfNextSunday = getNextSunday(dateToday)
  end
  
  #Removes the adventure from the cart.
  def remove
    id = params[:id]
    
    cart = session[:cart]
    
    #Deletes adventure id key from the cart hash.
    cart.delete(id)
    
    redirect_to :action=> :index
  end
  
  #Decreases ticket count for an adventure of particular id in the cart.
  def decrease
    id = params[:id]
    cart = session[:cart]
    
    #Deletes adventure id key from the cart hash if it only had one ticket selected.
    if cart[id]["ticketQuantity"] == 1
      cart.delete(id)
    else
      #Decreases adventure ticket count by one in the adventure hash.
      cart[id]["ticketQuantity"] = cart[id]["ticketQuantity"] - 1
    end
    
    redirect_to :action=> :index
  end
  
  #Triggered from the cart view to increase adventure ticket count by 1.
  def increase
    id = params[:id]
    cart = session[:cart]
    
    cart[id]["ticketQuantity"] = cart[id]["ticketQuantity"] + 1
    
    redirect_to :action=> :index
  end
  
  #Empties out the cart by setting cart in session to an empty hash.
  def cancel
    session[:cart] = {}
    redirect_to '/adventures'
  end
  
  #Loops through each adventure's hash in the cart hash and uses the adventure
  #ticket count and date to create a booking that is then assigned to the user
  #signed in.
  def createBooking
    @cart = session[:cart]
    
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
    
    #After creating the bookings, the cart is set back to an empty hash.
    session[:cart] = {}
    
    redirect_to '/bookings'
  end
  
  #Triggered when user picks a different date for the adventure in the cart from
  #the date picker select's dropdown options.
  def updateItemDate
    #Gets affected adventure id and the new adventure date from params.
    itemId = params[:id]
    itemNewDate = params[:d]
    
    cart = session[:cart]
    
    #Gets adventure hash from the cart hash.
    itemInfo = cart[itemId]
    #Assigns the adventure the new adventure date.
    itemInfo["adventureDate"] = itemNewDate
    
    redirect_to :action=> :index
  end
  
end

