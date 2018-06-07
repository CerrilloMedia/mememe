class Post < ActiveRecord::Base
  acts_as_votable

  validates :image, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments

  has_attached_file :image, styles: { :medium => "640x" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/
  accepts_nested_attributes_for :comments

  # paginates_per 3
end
