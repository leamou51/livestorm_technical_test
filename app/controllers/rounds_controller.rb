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
    direction = @rounds_view.ask_for("direction")
    case direction
    when "left" then create(select_room(3).sample, user)
    when "right" then create(select_room(2).sample, user)
    when "forward" then create(select_room(4).sample, user)
    end
  end

  def play(user)
    round = move(user)
    @rounds_view.display_welcome(round.room.name)
    safe_opening(user) if round.room.item == true
    @rounds_view.display_loose if user.health_point.zero?
    @rounds_view.display_fight_announcement(round.room.enemy.name)
    while round.room.enemy.health_point.positive? && user.health_point.positive?
      fight(user, round)
    end
    round.room.enemy.health_point.zero? ? @rounds_view.display_win : @rounds_view.display_loose
  end

  def safe_opening(user)
    @rounds_view.display_safe_opening
    choice = @rounds_view.ask_for("choice")
    if choice == "yes" && trap_proba(user)
      user.health_point -= rand(1..2)
      user.health_point = 0 if user.health_point.negative?
      @rounds_view.display_safe_curse(user.health_point)
    elsif choice == "yes" && !trap_proba(user)
      user.health_point += rand(1..2)
      @rounds_view.display_safe_healing(user.health_point)
    else
      @rounds_view.display_safe_unopening
    end
    user.save
  end

  def fight(user, round)
    @rounds_view.display_attacks(user.adventurer.attacks)
    @rounds_view.choose("attack")
    if fight_proba(user, round)
      user.health_point -= 1 * round.room.enemy.level
      user.health_point = 0 if user.health_point.negative?
      @rounds_view.display_fight_loose(user.health_point)
    else
      round.room.enemy.health_point -= 1 * user.adventurer.strength
      round.room.enemy.health_point = 0 if round.room.enemy.health_point.negative?
      @rounds_view.display_fight_win(round.room.enemy.health_point)
    end
  end

  private

  def select_room(lvl)
    Room.all.to_a.reject { |room| room.enemy.level > lvl }
  end

  def trap_proba(user)
    arr_false = (0..user.adventurer.luck - 1).map { |n| n = false }
    arr_true = (0..4 - user.adventurer.luck).map { |n| n = true }
    arr_true.concat(arr_false).sample
  end

  def fight_proba(user, round)
    skills = user.adventurer.strength * 4 + user.adventurer.sagacity + user.adventurer.trickery * 2 + user.adventurer.luck * 3
    u_arr_false = (0..skills - 1).map { |n| n = false }
    u_arr_true = (0..49 - skills).map { |n| n = true }
    user_weight = u_arr_true.concat(u_arr_false)
    e_arr_true = (0..round.room.enemy.level * 10 - 1).map { |n| n = true }
    e_arr_false = (0..49 - round.room.enemy.level * 10).map { |n| n = false }
    enemy_weight = e_arr_true.concat(e_arr_false)
    user_weight.concat(enemy_weight).sample
  end
end
