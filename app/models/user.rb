class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  #After Commit Actions
  after_commit :add_def_avatar, on: %i[create update]
  
  #ActiveRecord Associations
  has_many :tasks, dependent: :destroy
  has_many :quotes, dependent: :destroy
  has_one_attached :avatar
  
  #Validations, Other Validations are handled by Devise.
  
  #Custom Image Validation
  validate :acceptable_image
  
  #Role Management is in concerns/roleable.rb to avoid congestion.
  include Roleable
  
  #Default Role of User
  after_create do
    self.first_role
  end
  
  #When pulling information with recent, sort by user creation date, descended. (New to Old)
  scope :recent, lambda { order(created_at: :desc) }
  
  #Omit surname from profiles for privacy concerns.
  def private_name
    first_name + " " + last_name.slice(0) + "."
  end
  
  #Return user age
  def age
    return nil unless birthday.present?
    today = Time.current.to_date
    if today.month < birthday.month || (today.month == birthday.month && birthday.day > today.day)
      today.year - birthday.year - 1
    else
      today.year - birthday.year
    end
  end
  
  #Give default role of client to signups, unless first signup, in which case, give role of admin.
  def first_role
    if self.id == 1
      self.update(admin: true)
    else
      self.update(client: true)
    end
  end
  
  #
  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "250x250!").processed
    else
      "/def_avatar.png"
    end
  end

  private
  #Method for default avatar.
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

  #Custom validation to check for image size. Image type is checked automatically by ActiveRecord.
  def acceptable_image
    return unless avatar.attached?
    unless avatar.blob.byte_size <= 3.megabyte
      errors.add(:avatar, "is too large.")
    end
  end
end
