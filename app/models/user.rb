class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { :medium => '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :username, presence: true, length: { minimum: 4, maximum: 12 }
end
