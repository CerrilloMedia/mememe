class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
  validates_length_of :content, within: 3..300, too_short: "comment is too short, please try again", too_long: "comment is too long, please try again"
end
