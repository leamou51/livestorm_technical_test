require_relative "../models/round"
require_relative "../views/rounds_view"

class RoundsController
  def initialize
    @rounds_view = RoundsView.new
  end

  def create(room, user)
    round = Round.new(room: room, user: user)
    round.save
    round
  end

  def move(user)
    direction = @rounds_view.aks_for_direction
    case direction
    when "left" then create(select_room(3).sample, user)
    when "right" then create(select_room(2).sample, user)
    when "forward" then create(select_room(4).sample, user)
    end
  end

  def play(user)
    round = move(user)
    @rounds_view.display_rules(round.room.name)
  end

  private

  def select_room(lvl)
    Room.all.to_a.reject { |room| room.enemy.level > lvl }
  end
end
