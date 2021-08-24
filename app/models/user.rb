class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one_attached :avatar
  after_commit :add_def_avatar, on: %i[create update]
  has_many :tasks, dependent: :destroy
  has_many :quotes, dependent: :destroy
  validate :acceptable_image

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

  scope :recent, lambda { order(created_at: :desc) }

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

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "250x250!").processed
    else
      "/def_avatar.png"
    end
  end

  private

  def add_def_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            "app", "assets", "images", "def_avatar.png"
          )
        ),
        filename: "def_avatar.png",
        content_type: "image/png",
      )
    end
  end

  def acceptable_image
    return unless avatar.attached?
    unless avatar.blob.byte_size <= 3.megabyte
      errors.add(:avatar, "is too large.")
    end
  end
end
