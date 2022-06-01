class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
   def after_sign_in_path_for(resource) 
      users_path
   end
  
   def after_sign_up_path_for(resource) 
      top_path
   end
  
   def after_sign_out_path_for(resource)
      new_user_session_path # ログアウト後に遷移するpathを設定
   end

  private
   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
   end
end