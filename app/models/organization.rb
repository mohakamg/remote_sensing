class Organization < ApplicationRecord
  has_many :users
  has_many :sensors

  has_many :data

end
