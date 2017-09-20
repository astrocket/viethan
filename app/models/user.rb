class User < ApplicationRecord
  validates :display_name, presence: true, uniqueness: true
  before_validation :uniq_display_name!, on: :create

  def display_name=(value)
    super(value ? value.strip : nil)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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
end
