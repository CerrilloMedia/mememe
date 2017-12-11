require 'rails_helper'

feature 'Creating a new user' do

  background do
    # visit the home pages
    # user = create :user
    visit '/'
    # Click on register link
    click_link 'Register'

  end

  scenario 'can create a new user via the index page' do
    # Fill in the Username field with 'dlskjfupaio'
    fill_in 'User name', with: 'dlskjfupaio'
    # Fill in the Email field with 'dlskjfupaio@example.com'
    fill_in 'Email', with: 'dlskjfupaio@example.com'
    # Fill in the 'Password' field with 'supersecret'
    find('#user_password').set('supersecret')
    # Fill in the 'Password' field with 'supersecret'
    fill_in 'Password confirmation', with: 'supersecret'
    # Click the 'Sign Up' button
    click_button 'Sign up'
    # Expect the page to have the message 'Welcome! You have signed up successfully.'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'requires a user name to successfully create an account' do
    fill_in 'User name', with: ''
    fill_in 'Email', with: 'jasdfjfjlkd@example.com'
    find('#user_password').set('password')
    find('#user_password_confirmation').set('password')
    click_button 'Sign up'

    expect(page).to have_content("can't be blank")
  end

  scenario 'requires a user name to be more than 4 characters' do
    fill_in 'User name', with: 'h'
    fill_in 'Email', with: 'jasdfjfjlkd@example.com'
    find('#user_password').set('password')
    find('#user_password_confirmation').set('password')
    click_button 'Sign up'

    expect(page).to have_content("minimum is 4 characters")

  end

  scenario 'requires a user name to be no more than 12 characters' do
    fill_in 'User name', with: 'h' * 13
    fill_in 'Email', with: 'jasdfjfjlkd@example.com'

    fill_in 'Password', with: 'password', match: :first # utilizing match: :first allows for any possible duplicate elements being found which may contain the same term, in this case it's 'Password' which is also in 'Password confirmation'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content("maximum is 12 characters")

  end

end
