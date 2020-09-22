require_relative "../app/models/user"
require_relative "../app/models/adventurer"
require_relative "../app/models/enemy"
require_relative "../app/models/room"

puts "Cleaning DB..."

Adventurer.destroy_all
Enemy.destroy_all
Room.destroy_all

puts "DB cleaned!"

puts "Creating adventurers..."

Adventurer.new(name: "Adventurer1", strength: 2, sagacity: 1, luck: 4, trickery: 1, attacks: "attack1 attack2", shields: "shield1 shield2", quote: "quote1").save
Adventurer.new(name: "Adventurer2", strength: 4, sagacity: 3, luck: 1, trickery: 5, attacks: "attack1 attack2", shields: "shield1 shield2", quote: "quote2").save
Adventurer.new(name: "Adventurer3", strength: 3, sagacity: 4, luck: 3, trickery: 2, attacks: "attack1 attack2", shields: "shield1 shield2", quote: "quote3").save
Adventurer.new(name: "Adventurer4", strength: 5, sagacity: 2, luck: 2, trickery: 3, attacks: "attack1 attack2", shields: "shield1 shield2", quote: "quote4").save

puts "Adventurers created!"

puts "Creating enemies..."

Enemy.new(name: "Enemy1", level: 1, health_point: 5).save
Enemy.new(name: "Enemy2", level: 2, health_point: 5).save
Enemy.new(name: "Enemy3", level: 3, health_point: 5).save
Enemy.new(name: "Enemy4", level: 4, health_point: 5, boss: true).save
Enemy.new(name: "Enemy5", level: 2, health_point: 5).save
Enemy.new(name: "Enemy6", level: 3, health_point: 5).save
Enemy.new(name: "Enemy6", level: 1, health_point: 5).save

puts "Enemy created!"

puts "Creating rooms..."

Room.new(name: "Room1", item: [true,false].sample, enemy: Enemy.all.sample).save
Room.new(name: "Room2", item: [true,false].sample, enemy: Enemy.all.sample).save
Room.new(name: "Room3", item: [true,false].sample, enemy: Enemy.all.sample).save
Room.new(name: "Room4", item: [true,false].sample, enemy: Enemy.all.sample).save
Room.new(name: "Room5", item: [true,false].sample, enemy: Enemy.all.sample).save
Room.new(name: "Room6", item: [true,false].sample, enemy: Enemy.all.sample).save

puts "Rooms created!"
