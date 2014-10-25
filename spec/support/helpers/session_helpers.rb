module Features
  module SessionHelpers
    def sign_up_with(user)
      visit new_user_registration_path
      fill_in 'Name', with: user.name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', :with => user.password
      click_button 'Sign up'
    end

    def signin(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end
  end
end
