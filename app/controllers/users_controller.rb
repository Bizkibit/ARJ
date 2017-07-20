class UsersController < ApplicationController
  before_action :find_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'New User created'
      redirect_to user_path(@user)
    else
      flash[:alert]= 'fix the errors'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :dob, :email, :picture, :password, :password_confirmation, :bio)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
