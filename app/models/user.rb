class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(10)
    # self.token = loop do
      SecureRandom.hex(10)
      # break unless self.class.exists?(token: token)
    # end
  end
end
