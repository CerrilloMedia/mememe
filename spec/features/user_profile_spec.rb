require 'rails_helper'

feature 'Viewing user profile' do

  # user, post, user_two, post_two = "","","",""

  background do

    # Create a user.
    $user = create :user
    # Create a second user.
    $user_two = create(:user, email: 'predator@example.com',
                              username: 'predator',
                              password: 'threedots',
                              id: $user.id + 1 )
    # Create a post owned by the user
    $post = create(:post,  user_id: $user.id)
    # Create a post owned by the second user
    $post_two = create(:post, caption: "hunting season is on!",
                             user_id: $user.id + 1)
    # Sign in with the first user
    sign_in_with $user
    # Visit the dashboard.
    visit "/"
    # Click the first user's user name
    find(:xpath, "//a[contains(@href, '#{$user.username}')]").click

    # puts "finished creating users and posts:"
  end

  scenario 'visiting a profile page shows the user name in the url' do
    expect(page.current_path).to eq("/#{$user.username}")
  end

  scenario "a profile page only shows the specified user's posts" do
    # Expect the page to show the user-owned post.
    expect(page).to have_content("#{$post.caption}")
    # Expect the page to NOT show other user's post.
    expect(page).not_to have_content("#{$post_two.caption}")
  end

end

feature 'editing user profile' do

  background do

    # Create a user.
    $user = create :user
    # Create a second user.
    $user_two = create(:user, email: 'predator@example.com',
                              username: 'predator',
                              password: 'threedots',
                              id: $user.id + 1 )
    # Create a post owned by the user
    $post = create(:post,  user_id: $user.id)
    # Create a post owned by the second user
    $post_two = create(:post, caption: "hunting season is on!",
                             user_id: $user.id + 1)
    # Sign in with the first user
    sign_in_with $user

  end

  scenario 'a user can change their own profile details' do

    # click first users user name
    find(:xpath, "//a[contains(@href), '#{$user.username}']").click
    # click the edit button
    click_link "Edit Profile"
    # click the choose new profile image button
    click_button "Choose File"
    # select new image

    # fill in bio field with 'Is this real life?'

    # click the "Update Profile" button

    # expect to be routed to the first users profile page

    # expect to see the updated profile image

    # expect to see the updated profile bio

  end

  scenario 'a user can not change anotehr users profile details' do

    # click first users user name

    # Expect to not see the "Edit Profile" button

  end

  scenario 'a user can not navigate directly to edit a users profile' do

    # Directly visit the another users profile edit url

    # Expect to not see "Change your profile image:"

    # Expect the path to be the root path

    # Expect to see the message, "That profile doesn't belong to you!"

  end

end
