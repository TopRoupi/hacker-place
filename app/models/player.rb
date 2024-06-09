# == Schema Information
#
# Table name: players
#
#  id              :uuid             not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  verified        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  computer_id     :uuid
#
# Indexes
#
#  index_players_on_computer_id  (computer_id)
#  index_players_on_email        (email) UNIQUE
#
class Player < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end
  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy
  belongs_to :computer, optional: true

  validates(
    :email,
    presence: true,
    uniqueness: true,
    format: {with: URI::MailTo::EMAIL_REGEXP}
  )
  validates(
    :password,
    allow_nil: true,
    length: {minimum: 6}
  )

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  after_commit :create_computer, on: [:create]

  def create_computer
    update!(computer: Computer.create)
  end
end
