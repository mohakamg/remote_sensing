class Sensor < ApplicationRecord
  has_many :data
  belongs_to :organization
end
