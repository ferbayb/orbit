class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :tasks, dependent: :destroy

  def private_name
    first_name + " " + last_name.slice(0) + "."
  end

  def age
    return nil unless birthday.present?
    today = Time.current.to_date
      if today.month < birthday.month || (today.month == birthday.month && birthday.day > today.day)
        today.year - birthday.year - 1
      else
        today.year - birthday.year
      end
  end
end
