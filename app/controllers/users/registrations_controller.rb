class Users::RegistrationsController < Devise::RegistrationsController  
  
  def new
    if User.where(:id => 1).blank?
      @page_title="Register Admin Account" or "Register"
    end
    super
  end
  
  def create
    @page_title="Register"
    super
  end
  private
  
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
