class Chat < ApplicationRecord

  after_create :generate_intro_message
  belongs_to :user
  has_many :messages

  def recent_message
    self.messages.last
  end

  private

    def generate_intro_message
      self.messages.create(user: self.user, content: 'Hi !')
    end

end
