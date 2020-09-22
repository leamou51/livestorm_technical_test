require_relative "../models/adventurer"
require_relative "../views/adventurers_view"

class AdventurersController
  def initialize
    @adventurers_view = AdventurersView.new
  end

  def index
    adventurers = Adventurer.all.to_a
    @adventurers_view.display_adventurers(adventurers)
  end

  def find_from_index
    index
    adventurer_index = @adventurers_view.ask_for_index("adventurer").to_i - 1
    Adventurer.all.to_a[adventurer_index]
  end
end
