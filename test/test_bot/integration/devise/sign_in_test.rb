require 'test_helper'

if defined?(Devise) && defined?(User)
  module TestBot
    class SignInTest < ActionDispatch::IntegrationTest
      let(:user) { users(:normal) }

      test 'valid sign in' do
        visit new_user_session_path

        binding.pry

        within('form#new_user') do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'password'
          find('input[type=submit]').click
        end

        assert_equal 200, page.status_code
        assert_content I18n.t('devise.sessions.signed_in')

        assert_equal 1, User.find_by_email(user.email).sign_in_count
      end

      test 'invalid sign in' do
        visit new_user_session_path

        binding.pry

        within('form#new_user') do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'not-correct-password'
          find('input[type=submit]').click
        end

        assert_equal 200, page.status_code
        assert_content I18n.t('devise.failure.invalid', authentication_keys: Devise.authentication_keys.join(', '))
      end
    end
  end
end

# require 'rails_helper'

# if defined?(Devise) && defined?(User)

#   feature 'Devise Sign In' do
#     let(:user) do
#       User.new(email: "user_#{Time.now.to_i}@example.com", password: '1234567890').tap { |u| u.save(validate: false) }
#     end

#     it 'allows a valid sign in' do
#       visit new_user_session_path

#       within('form#new_user') do
#         fill_in 'user_email', with: user.email
#         fill_in 'user_password', with: user.password

#         find('input[type=submit]').click
#       end

#       expect(page.status_code).to eq 200
#       expect(page).to have_content I18n.t('devise.sessions.signed_in')

#       existing_user = User.find_by_email(user.email)
#       expect(existing_user.sign_in_count).to eq 1

#     it 'prevents sign in when provided an invalid password' do
#       visit new_user_session_path

#       within('form#new_user') do
#         fill_in 'user_email', with: user.email
#         fill_in 'user_password', with: 'invalid_password'

#         find('input[type=submit]').click
#       end

#       expect(page.status_code).to eq 200
#       expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: Devise.authentication_keys.join(', '))
#     end

#   end

# end # /defined?(Devise)