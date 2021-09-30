require_relative 'feature_helper'

feature 'Create answer', %q{
  In order to exchange knowledge
  As an authenticated user
  I want to be able to create answers
} do

  let!(:user) { create(:user) }
  given!(:question) { create :question }

  scenario 'Authenticated user creates answer', js: true do
    
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    find('.answers', visible: true)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'User tries to create an invalid answer', js: true do
    sign_in user
    visit question_path(question)
    click_on 'Create'
    find('.answers', visible: false)
    expect(page).to have_content 'MyString MyText Your answer'
  end
end
