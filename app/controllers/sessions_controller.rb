class SessionsController < ApplicationController
  def new
  end

  def create
    u = User.find_by(email: params[:session][:email].downcase)
    if u && u.authenticate(params[:session][:password])
      flash[:success] = "Succesfully Logged In"
      sign_in u
      redirect_to u
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


end
