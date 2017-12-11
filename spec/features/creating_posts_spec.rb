require 'rails_helper.rb'

feature 'Creating posts' do

  background do
    user = create :user

    sign_in_with user

  end

  scenario 'can create a post' do
    visit '/'
    click_link 'New Post', match: :first
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #coffeetime'
    click_button 'Create'
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
    expect(page).to have_content('Arnie')
  end

  it 'needs an image to create a post' do
    visit '/'
    click_link 'New Post', match: :first
    fill_in 'Caption', with: 'skipped the image'
    click_button 'Create'
    expect(page).to have_content('Halt, you fiend! You need an image to post here!')
  end

end
