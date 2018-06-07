require 'rails_helper'

feature "posts likes!!" do

  background do

    # Create a user via factory_bot
    $user = create :user # default user from factory bot
    # Create a post for the above user.
    $post = create(:post, user_id: $user.id)

    # Sign in
    sign_in_with $user
    # Visit the root route
    visit '/'

    expect(page).to have_content("#{$post.caption}")
    expect(page).to have_content("#{$user.username}")

  end

  scenario 'can like a post' do

    # click the 'like' button for the above post.
    find('.like-button').click
    # Expect to see a 'liked-post' class appear for the button (button will turn solid red ala Instagram)
    expect(page).to have_css('div.liked-post')
    # Expect to see my name within the 'like by' area of the post
    # within('.like-by') do
    #   expect(page).to contain($user.username)
    # end
  end

  scenario 'can unlike a post' do
    # repeat the above steps to like a post

    # Click the like button once more.

    # Expect to see the "unlikes-post" class on the button.
  end

end
