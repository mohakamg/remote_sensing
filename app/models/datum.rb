class Datum < ApplicationRecord
  belongs_to :organization
  belongs_to :sensor
end
