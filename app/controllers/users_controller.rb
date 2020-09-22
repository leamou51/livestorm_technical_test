require_relative "../models/user"
require_relative "../views/users_view"

class UsersController
  def initialize
    @users_view = UsersView.new
  end

  def create
    username = @users_view.ask_for_username
    User.new(name: username).save if User.find_by(name: username).nil?
    @users_view.welcome(username)
  end
end
