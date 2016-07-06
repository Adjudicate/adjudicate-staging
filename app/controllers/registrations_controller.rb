class RegistrationsController < Devise::RegistrationsController

	def new
    @new_user = User.new
  	end


  	def create
    	@user = User.new(sign_up_params)
    if @user.save
      redirect_to new_user_session_path
    else
      redirect_to new_user_registration_path
    end
  end
 
  private


 
    def sign_up_params
      params.require(:user).permit(:role, :email, :password)
    end
   
    def account_update_params
      params.require(:user).permit(:role, :email, :password, :password_confirmation, :current_password)
    end
    
end