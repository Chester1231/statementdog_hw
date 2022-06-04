# frozen_string_literal: true

module UserMacros
  def login_user
    before(:each) do
      @user = create(:user)
      session[:user_token] = @user.id
    end
  end
end
