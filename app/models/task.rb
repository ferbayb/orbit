class Task < ApplicationRecord
    validates :address, presence: true
    validates :description, presence: true, length: { minimum: 25, maximum: 500 }
    validates :latitude, presence: true, numericality: { greater_than: -43.00311, less_than: -12.46113, message: "must be within Australian ranges." }
    validates :longitude, presence: true, numericality: { greater_than: 113.6594, less_than: 153.61194, message: "must be within Australian ranges."  }

    def map_embed(lat, lon)
        "https://www.google.com/maps/embed/v1/place?q=#{lat}%2C#{lon}&key=AIzaSyBWcv3SgzJkW2biuy0ii1Tjf-EhCNzhYz8"
    end

    def map_link(center)
        "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=700x250&zoom=13&markers=size:mid%7Ccolor:0xe34149%7Clabel:%7C#{center}&key=AIzaSyBWcv3SgzJkW2biuy0ii1Tjf-EhCNzhYz8"
    end
end
