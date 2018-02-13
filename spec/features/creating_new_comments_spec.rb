require 'rails_helper'

feature 'Commenting on posts' do

  background do
    user = create :user
    user_two = create(:user, email: 'everything@example.com',
                             username: 'BennyBoy',
                             id: user.id + 1)

    post = create(:post, user_id: user.id )
    post_two = create(:post, user_id: user_two.id,
                             caption: 'second post')
    sign_in_with user
    visit '/'
  end

  scenario 'user can comment on own post' do
    # in nested forms [post, post.comments.new] Capybara will be looking for:
    # name = comment[content]
    # id = comment_content
    within('div#post_1') do
      fill_in "comment_content_1", with: 'content for first post'
      click_button 'Submit'
    end

    expect(page).to have_content('content for first post')

  end

  scenario 'user can comment on user_two post' do
    within('div#post_2') do
      fill_in "comment_content_2", with: ':)))'
      click_button 'Submit'
    end

    expect(page).to have_content(':)))')
  end



end
