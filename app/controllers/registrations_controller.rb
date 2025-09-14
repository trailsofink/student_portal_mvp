class RegistrationsController < ApplicationController
  skip_before_action :require_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update]

  before_action :set_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: 'Successfully signed up!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Successfully updated!'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
