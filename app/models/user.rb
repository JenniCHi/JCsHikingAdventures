class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def user_params
    #I added the permittance of a user name here in addition to the devise defaults.
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_me)
  end

  #Here we are associating many bookings with one user.
  has_many :bookings
end
