require 'rails_helper'

feature 'Create answer', %q{
  In order to exchange knowledge
  As an authenticated user
  I want to be able to create answers
}do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    find('.answers', visible: false)
    within '.answers' do
      expect(page).to have_content ''
    end
  end
end
