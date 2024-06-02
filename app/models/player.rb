class Player < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  belongs_to :computer, optional: true

  after_commit :create_computer, on: [:create]

  def create_computer
    update!(computer: Computer.create)
  end
end
