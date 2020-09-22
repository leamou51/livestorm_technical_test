class Room < ActiveRecord::Base
  belongs_to :enemy
  has_many :rounds
end
