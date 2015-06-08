require "test_helper"

module TestBot
  class HomePageTest < ActionDispatch::IntegrationTest
    let(:something) { User.new(:email => 'homepagetest@someone.com') }

    test "sanity" do
      visit root_path
      page.save_screenshot('something.png')

      assert_equal current_path, 'http://something.com', 'unexpected root_url'

      assert_content "Testbot home page spec!"
    end

    test "does something" do
      visit root_path
      page.must_have_content "Test bot home page spec!"
    end

  end
end
