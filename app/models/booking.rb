class Booking < ApplicationRecord
  belongs_to :user
  
  def booking_params
    params.require(:booking).permit(:user_id) 
  end
  
end
