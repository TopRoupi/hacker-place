require "test_helper"

Capybara.register_driver :my_playwright do |app|
  Capybara::Playwright::Driver.new(app,
    browser_type: ENV["PLAYWRIGHT_BROWSER"]&.to_sym || :firefox,
    # browser_type: ENV["PLAYWRIGHT_BROWSER"]&.to_sym || :chromium,
    headless: (false unless ENV["CI"] || ENV["PLAYWRIGHT_HEADLESS"]),
    playwright_cli_executable_path: './node_modules/.bin/playwright-core'
                                  )
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :my_playwright, screen_size: [1000, 700]

  def sign_in_as(player)
    visit sign_in_url
    fill_in :email, with: player.email
    fill_in :password, with: "123456"
    click_on "Sign in"

    assert_current_path root_url
    player
  end
end
