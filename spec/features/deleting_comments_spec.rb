require 'rails_helper'

feature 'Deleting comments' do

  background do
    user = create :user
    user_two = create(:user, email: 'meh@example.com',
                             username: 'mehhhh' ,
                             password: 'mehhhh',
                             id: user.id + 1 )

    expect(User.count).to eq 2
    post = create(:post, user_id: user.id)
    comment = create(:comment, post_id: post.id, user_id: user_two.id )
    comment_two = create(:comment, id: 2,
                                   post_id: post.id,
                                   content: "this is 2nd comment",
                                   user_id: user.id)

    sign_in_with user_two
  end

  scenario 'user can delete their own comment' do
    visit '/'

    expect(page).to have_content('My rude comment should be deleted')

    within("#comment_1") do
      find('.comment-delete').click
    end

    expect(page).not_to have_content('My rude comment should be deleted')
  end

  scenario 'user can not delete someone elses comment from the view' do
    visit '/'

    within("#comment_2") do
      expect(page).not_to have_link('.comment-delete')
    end

    expect(page).to have_content('this is 2nd comment')
  end

  scenario 'user can not delete someone elses comment through url' do
    visit '/'

    expect(page).to have_content('this is 2nd comment')

    page.driver.submit :delete, "/posts/1/comments/2", {}

    expect(page).to have_content('this is 2nd comment')
    expect(page).to have_content('Unable to remove comment.')
  end

end
