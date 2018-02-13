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
                                   user_id: user_two.id)
    comment_three = create(:comment, id: 3,
                                   post_id: post.id,
                                   content: "this is the 3rd comment",
                                   user_id: user_two.id)
    comment_four = create(:comment, id: 4,
                                   post_id: post.id,
                                   content: "this is the 4th comment",
                                   user_id: user.id)
    comment_four = create(:comment, id: 5,
                                   post_id: post.id,
                                   content: "this is the 5th comment",
                                   user_id: user_two.id)
    sign_in_with user_two
  end

  scenario 'user can delete their own comment' do
    visit '/'

    expect(page).to have_content('this is the 5th comment')

    within("#comment_5") do
      find('.comment-delete').click
    end

    expect(page).not_to have_content('this is the 5th comment')
  end

  scenario 'user can not delete someone elses comment from the view' do
    visit '/'

    within("#comment_4") do
      expect(page).not_to have_link('.comment-delete')
    end

    expect(page).to have_content('this is the 4th comment')
  end

  scenario 'user can not delete someone elses comment through url' do
    # user logged in
    visit '/'

    expect(page).to have_content('this is the 4th comment')

    page.driver.delete '/posts/1/comments/4', {}

    expect(page).to have_content('this is the 4th comment')
  end

  scenario 'deleting 5th comment still displays only 3 comments' do
    visit '/'

    within('#comment_5') do
      find('.comment-delete').click
    end

    expect(page).not_to have_selector('#comment_5');
    expect(page).to have_selector('.comment', count: 3);

  end

end
