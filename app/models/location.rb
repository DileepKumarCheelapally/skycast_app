class Location < ApplicationRecord
  belongs_to :user
  geocoded_by :city
  after_validation :geocode
end
