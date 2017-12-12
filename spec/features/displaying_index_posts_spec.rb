require 'rails_helper'

feature 'Index displays a list of posts' do

  before do
    user = create :user
    @post_one = create(:post, user_id: user.id)
    @post_two = create(:post, caption: "This is the second post", user_id: user.id)

    sign_in_with user

  end

  scenario 'the index displays correct created post information' do
    expect(Post.all.count).to equal(2)

    expect(page).to have_content("#{@post_one.caption}")
    expect(page).to have_content("#{@post_two.caption}")
    expect(page).to have_css("img[src*='coffee']")

  end

  scenario 'clicking index image and render individual post page' do
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    expect(page.current_path).to eq(post_path(@post_one))
  end

end
