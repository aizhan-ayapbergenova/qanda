require 'rails_helper'

feature 'Create questions', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask question
}do  
  
  given(:user) { create(:user) }

  scenario 'Authenticated user creates questions' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in('Title', with: 'Test question')
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content ""
  end

  scenario 'Unauthenticated user tries to ask questions' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

end
