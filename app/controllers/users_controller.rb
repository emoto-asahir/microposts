class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :check_user, only: [:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App! please Log in"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end
  
  def show_followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  def show_followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def check_user
     @user = User.find(params[:id])
     if @user != current_user
       redirect_to root_url
     end
  end
end
