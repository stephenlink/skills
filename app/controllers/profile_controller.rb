class ProfileController < ApplicationController
  before_action :set
  before_action :own_profile, only: [:edit, :update]


 
  def show
  	#@user = User.find_by(user_name: params[:user_name])
  	@posts = User.find_by(user_name: params[:user_name]).posts.order(:cached_votes_up => :desc)
  end

  def edit
    #@user = User.find_by(user_name: params[:user_name])
  end

  def update
    #@user = User.find_by(user_name: params[:user_name])
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private 

  def profile_params
  	params.require(:user).permit(:avatar, :bio)
  end

  before_action :authenticate_user!

  def own_profile
  	#@user = User.find_by(user_name: params[:user_name])
  	unless current_user == @user
  		flash[:alert] = "Not your profile"
  		redirect_to root_path
  	end
  end

  def set
  	@user = User.find_by(user_name: params[:user_name])
  end

end
