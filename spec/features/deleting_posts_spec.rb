require 'rails_helper'

feature "Deleting Posts" do

  caption = "Abs for days."

  background do
    user = create :user
    post = create(:post, caption: caption)

    sign_in_with user

    # click on post#show on post#index
    find(:xpath, "//a[contains(@href, '/posts/1')]").click

    # within post#show view click on 'Edit Post'
    click_link('Edit Post')
  end

  scenario "can delete a post" do
    # within post#edit view click on 'Delete Post'
    click_link "Delete Post"

    # expect to see the message "Problem solved! Post deleted."
    expect(page).to have_content("Problem solved! Post deleted.")

    # expect to not see the old post anymore.
    expect(page).not_to have_content(caption)

  end
end
