require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before do
    @user = create(:user)
    @post = create(:post, user_id: @user.id)
  end

  describe "POST #create" do
    context "with valid attributes" do

      it "saves the new comment in the database" do
        comment = create(:comment, user_id: @user.id, post_id: @post.id )
        expect(Comment.count).to eq(1)
      end

    end
  end
end
