require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(current_path).to eq("/users/new")
  end

  feature 'signing up a user' do
    before(:each) do
        visit new_user_url
        fill_in "Username", :with => "Nobodyman"
        fill_in "Password", :with => "everybodywoman"
        click_button "nice"
    end

    scenario 'shows username on the homepage after signup' do
        expect(page).to have_content("Nobodyman")
    end

  end
end

feature 'logging in' do
  let!(:user) { User.new(username: "puppies4ever", password: "jkcatsforever") }

  before(:each) do
      user.save!
      visit new_session_url
      fill_in "Username", :with => "puppies4ever"
      fill_in "Password", :with => "jkcatsforever"
      click_button "neat"
  end

  scenario 'shows username on the homepage after login' do
    expect(page).to have_content("puppies4ever")
  end

end

feature 'logging out' do
  let!(:user) { User.new(username: "puppies4ever", password: "jkcatsforever") }
  
  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to have_content("Log In")
  end


  scenario 'doesn\'t show username on the homepage after logout' do
    user.save!
    visit new_session_url
    fill_in "Username", :with => "puppies4ever"
    fill_in "Password", :with => "jkcatsforever"
    click_button "neat"
    click_button "Log Out"
    
    expect(page).to_not have_content("puppies4ever")
  end
end