class SessionsController < ApplicationController
  def allowed
    {
      new: :guest,
      create: :guest,
      destroy: :member,
    }
  end

  def new
  end

  def create
    if @user = login(session_params[:email], session_params[:password])
      redirect_back_or_to after_sign_in_path
    else
      flash[:alert] = "Email or password is invalid"
      render :new
    end
  end

  def destroy
    logout
    flash[:info] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def after_sign_in_path
    if @user.admin
      admin_root_path
    else
      root_path
    end
  end

  def session_params
    params.require(:session).permit(%i[email password])
  end
end
