require 'rails_helper'

feature 'User Authentication' do

  background do
    user = create :user
  end

  scenario 'can log in from the index via dynamic navbar' do

    # visit Index
    visit '/'

    # expect the page to not have the New Post link yet
    expect(page).not_to have_content('New Post')

    # click the 'Login' links
    click_link 'Log in'

    # fill in the email, password fields
    fill_in 'Email', with: 'terminator@example.com'
    fill_in 'Password', with: 'illbeback'

    # click the 'Log In' button
    click_button 'Log in'

    # expect page to have content saying 'Signed in successfully'
    expect(page).to have_content('Signed in successfully.')

    # expect the 'Register' link to disappear
    expect(page).not_to have_content('Register')

    # expect the 'Logout' link to be present
    expect(page).to have_content('Logout')

  end

  scenario 'can log out once logged in' do
    # visit the Index
    visit '/'
    # click the 'Login' links
    click_link 'Log in'
    # fill in the email, password fields
    fill_in 'Email', with: 'terminator@example.com'
    fill_in 'Password', with: 'illbeback'
    # click the 'Log In' button
    click_button('Log in')
    # click the 'Log Out' button
    click_link('Logout')
    # expect page to have 'You need to sign in or sign up before continuing.' as Devise keeps user from viewing a page without being logged in
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'cannot view index without logging in' do
    # visit the root route
    visit '/'
    # expect the page to have content saying 'You need to sign in or sign up before continuing.'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'cannot create a new post without logging in' do
    # visit the root route
    visit '/'
    # expect the page to have content saying 'You need to sign in or sign up before continuing.'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

end
