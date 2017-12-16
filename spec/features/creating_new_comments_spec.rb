require 'rails_helper'

feature 'Commenting on posts' do

  background do
    user = create :user
    user_two = create :user()
    @post = create(:post, user_id: user.id )
    sign_in_with user
    visit '/'
  end

  scenario 'user can comment on own post' do
    # in nested forms [post, post.comments.new] Capybara will be looking for:
    # name = comment[content]
    # id = comment_content
    fill_in 'comment_content', with: ';P'
    click_button 'Submit'
    expect(page).to have_css("div.comments_#{@post.id}", text: ';P')
  end
  
end
