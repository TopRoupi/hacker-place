# == Schema Information
#
# Table name: sessions
#
#  id         :uuid             not null, primary key
#  ip_address :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :uuid             not null
#
# Indexes
#
#  index_sessions_on_player_id  (player_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#
class Session < ApplicationRecord
  belongs_to :player

  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end
end
