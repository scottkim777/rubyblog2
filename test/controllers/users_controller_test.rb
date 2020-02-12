require 'test_helper'


class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
   #@user = User.new(username: "johnx12", email: "johnx12@email.com", password: "password",
  #                   admin: false)
   #@user.save!
   @user = users(:one)
  end

  test "user show page" do
     get users_url
     #assert_response :success
  end

end
