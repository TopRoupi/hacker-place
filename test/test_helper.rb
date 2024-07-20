require "simplecov"
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors, threshold: 0)

  include FactoryBot::Syntax::Methods

  def sign_in_as(player)
    post(sign_in_url, params: {email: player.email, password: "123456"})
    player
  end
end
