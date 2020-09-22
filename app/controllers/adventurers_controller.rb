require_relative "../models/adventurer"
require_relative "../views/adventurers_view"

class UsersController
  def initialize
    @adventurers_view = AdventurersView.new
  end
end
