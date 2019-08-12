class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	#ストロングパラメータ
	protected
	 def configure_permitted_parameters
  	#ユーザ登録(sign_up)の際、ユーザ名(name)のデータ操作が許可される
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
