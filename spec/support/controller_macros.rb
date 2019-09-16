module ControllerMacros
  def login_user(user=nil)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user ||= FactoryGirl.create(:testuser)
    sign_in user
  end
end