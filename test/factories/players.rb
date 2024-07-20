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
#  machine_id      :uuid
#
# Indexes
#
#  index_players_on_email       (email) UNIQUE
#  index_players_on_machine_id  (machine_id)
#
FactoryBot.define do
  factory :player do
    association :machine

    email { "lol@lol.com" }
    password { "123456" }
  end
end
