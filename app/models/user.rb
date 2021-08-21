class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def private_name
    first_name + " " + last_name.slice(0) + "."
  end
end
