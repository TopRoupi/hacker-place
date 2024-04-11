class Computer < ApplicationRecord
  has_many :v_files

  def self.default_pc
    order(:created_at).last
  end
end
