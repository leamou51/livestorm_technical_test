require_relative "../models/adventurer"
require_relative "../views/adventurers_view"

class UsersController
  def initialize
    @adventurers_view = AdventurersView.new
  end

  def index
    adventurers = Adventurer.all.to_a
    @adventurer_view.display_adventurers(adventurers)
  end
end
