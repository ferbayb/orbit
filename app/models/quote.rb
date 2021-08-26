class Quote < ApplicationRecord
  #ActiveRecord Associations
  belongs_to :task
  belongs_to :user
  #Validations
  validates :content, presence: true, length: { minimum: 25, maximum: 110 }
  validates :price, :numericality => {:greater_than => 1, :less_than => 1000}
end
