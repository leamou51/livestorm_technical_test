class User < ActiveRecord::Base
  belongs_to :adventurer
  has_many :rounds
end
