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
    direction = @rounds_view.aks_for("direction")
    case direction
    when "left" then create(select_room(3).sample, user)
    when "right" then create(select_room(2).sample, user)
    when "forward" then create(select_room(4).sample, user)
    end
  end

  def play(user)
    round = move(user)
    @rounds_view.display_welcome(round.room.name)
    if round.room.item == true
      safe_opening(user)
    end
  end

  def safe_opening(user)
    @rounds_view.display_safe_opening
    choice = @rounds_view.aks_for("choice")
    if choice == "yes" && trap_proba(user)
      user.health_point -= rand(1..2)
      @rounds_view.display_safe_curse(user.health_point)
    elsif choice == "yes" && !trap_proba(user)
      user.health_point += rand(1..2)
      @rounds_view.display_safe_healing(user.health_point)
    else
      @rounds_view.display_safe_unopening
    end
    user.save
  end

  private

  def select_room(lvl)
    Room.all.to_a.reject { |room| room.enemy.level > lvl }
  end

  def trap_proba(user)
    arr_true = (0..user.adventurer.luck - 1).map { |n| n = false }
    arr_false = (0..4 - user.adventurer.luck).map { |n| n = true }
    arr_true.concat(arr_false).sample
  end
end
1
