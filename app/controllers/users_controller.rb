class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
    before_action :prevent_unauthorized_edit, only: [:edit]
  def new
  	@user =User.new
  end

 def create
 	@user = User.new(user_params)
	if @user.save
    session[:id] =@user
	redirect_to @user, notice: "Congratulation u are one of us" 
	else 
	flash.now[:alert] = "could not find"
  render :new
 end

  def edit
  end

  def show
  end

  private 

  def user_params 
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
      )
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def prevent_unauthorized_edit
    render text: "Not your account", status: :forbidden unless current_user == @user
  end
end