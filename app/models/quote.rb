class Quote < ApplicationRecord
  belongs_to :task
  belongs_to :user
  validates :content, presence: true, length: { minimum: 25, maximum: 110 }
end
