class User < ApplicationRecord
  validates :display_name, presence: true, uniqueness: true
  before_validation :uniq_display_name!, on: :create
  before_create :generate_verification_key

  def display_name=(value)
    super(value ? value.strip : nil)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    if exists?(provider: auth.provider, uid: auth.uid)
      where(provider: auth.provider, uid: auth.uid).first
    elsif exists?(provider: nil, email: auth.info.email)
      user = where(provider: nil, email: auth.info.email).first
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
      user
    else
      create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.display_name = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  # Makes the display_name unique by appending a number to it if necessary.
  # "Gleb" => Gleb 1"
  def uniq_display_name!
    if display_name.present?
      new_display_name = display_name
      i = 0
      while User.exists?(display_name: new_display_name)
        new_display_name = "#{display_name} #{i += 1}"
      end
      self.display_name = new_display_name
    end
  end

  def generate_verification_key
    key = SecureRandom.hex + Time.now.strftime("%Y%m%d%H%M%S")
    self.key = key
  end

end
