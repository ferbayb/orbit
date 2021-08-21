class Task < ApplicationRecord
    validates :address, presence: true

    def map_embed(lat, lon)
        "https://www.google.com/maps/embed/v1/place?q=#{lat}%2C#{lon}&key=AIzaSyBWcv3SgzJkW2biuy0ii1Tjf-EhCNzhYz8"
    end
end
