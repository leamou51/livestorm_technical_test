class AdventurersView
  def display_adventurers(adventurers)
    adventurers.each_with_index do |adventurer, index|
      puts "#{index + 1}. #{adventurer.name}\n--\n
      Strength: #{repeat("*", adventurer.strength)}\n
      Sagacity: #{repeat("*", adventurer.sagacity)}\n
      Trickery: #{repeat("*", adventurer.trickery)}\n
      Luck: #{repeat("*", adventurer.luck)}\n--\n
      War cry: '#{adventurer.quote}'\n"
    end
  end

  private

  def repeat(text, n)
    print text * n
  end
end
