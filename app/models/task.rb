class Task < ApplicationRecord
    belongs_to :user

    validates :address, presence: true
    validates :description, presence: true, length: { minimum: 25, maximum: 500 }
    validates :latitude, presence: true, numericality: { greater_than: -43.00311, less_than: -12.46113, message: "must be within Australian ranges." }
    validates :longitude, presence: true, numericality: { greater_than: 113.6594, less_than: 153.61194, message: "must be within Australian ranges."  }

    def map_embed(lat, lon)
        "https://www.google.com/maps/embed/v1/place?q=#{lat}%2C#{lon}&key=AIzaSyBWcv3SgzJkW2biuy0ii1Tjf-EhCNzhYz8"
    end
end
