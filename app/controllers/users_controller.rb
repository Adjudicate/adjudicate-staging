class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    get_user
  end

  def edit
    get_user
  end

  def update
    get_user
    if @user.update_attributes(user_params)
      render 'show'
    else
      #TODO: implement friendly redirects
      redirect_to edit_user_path(@user), :flash => { :error => @user.errors.full_messages }
    end
  end

  def invite_arbitrator
    dispute = Dispute.find_by_uid(params[:uid])
    if current_user.admin? && dispute
      params[:email].split(',').each do |email|
        user = User.find_or_initialize_by(email: email)
        temp_pw = nil
        if !user.persisted?
          temp_pw = SecureRandom.hex(5)
          user.password = temp_pw
          user.save
        end
        AdminMailer.delay.invite_arbitrator(user, dispute, temp_pw)
        DisputeUser.create(user: user, dispute: dispute)
      end
      redirect_to user_path(current_user)
    end
  end



  private

    def get_user
      @user = User.find_by_username(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email)
    end
end