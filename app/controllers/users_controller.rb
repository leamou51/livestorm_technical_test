require_relative "../models/user"
require_relative "../views/users_view"
require_relative "adventurers_controller"

class UsersController
  def initialize
    @users_view = UsersView.new
    @adventurers_controller = AdventurersController.new
  end

  # CREATE USER IF NEW PLAYER
  def current_user
    username = @users_view.ask_for_username
    create(username) if User.find_by(name: username).nil?
    User.find_by(name: username)
  end

  def create(username)
    User.new(name: username).save if User.find_by(name: username).nil?
  end

  # SELECT AN ADVENTURER
  def select_adventurer(user)
    adventurer = @adventurers_controller.find_from_index
    user.adventurer = adventurer
    user.save
    @users_view.go_on_mission(adventurer.name)
  end
end
