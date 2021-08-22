class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :tasks, dependent: :destroy

  include Roleable

  after_create do
    self.first_role
  end

  def all_roles
    roles = []
    User::ROLES.each do |r|
      role = r.to_s
      roles.push(role.humanize)
    end
    roles
  end

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

  def first_role
    if self.id == 1
      self.update(admin: true)
    else
      self.update(client: true)
    end
  end
end
