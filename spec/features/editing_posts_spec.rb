require 'rails_helper'

feature 'Editing posts' do

  # repeatable before any scenario test
  background do
    user = create :user
    user_two = create(:user, email: 'everything@example.com',
                             username: 'BennyBoy',
                             id: user.id + 1)
    post = create(:post, user_id: user.id )
    puts post_two = create(:post, user_id: user.id + 1)

    sign_in_with user
    visit '/'
  end

  scenario 'can edit a post as the owner' do
    find(:xpath, "//a[contains(@href, 'posts/1')]").click

    expect(page).to have_content("Edit Post")
    click_link "Edit Post"

    fill_in 'Caption', with: "Oh god, you weren't meant to see this picture!"
    click_button "Update Post"

    expect(page).to have_content("Post updated hombre")
    expect(page).to have_content("Oh god, you weren't meant to see this picture!")
  end

  scenario  "can not edit a post that doesn't belong to you via the show page" do
    find(:xpath, "//a[contains(@href, 'posts/2')]").click

    expect(page).not_to have_content("Edit Post")
  end

  scenario  "can not edit a post that doesn't belong to you via url page" do
    visit '/posts/2/edit'

    expect(page.current_path).to eq root_path
    expect(page).to have_content("That post doesn't belong to you!")
  end

  scenario "a Post won't update without an attached image" do
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    click_link "Edit Post"

    # fill_in 'Caption', with: "Oh god, you weren't meant to see this picture!"
    attach_file('Image','spec/files/images/coffee.zip')
    click_button 'Update Post'

    expect(page).to have_content("Something is wrong with your form!")
  end
end