module BuyableConcern
  extend ActiveSupport::Concern

  included do
    validates(
      :product_model_name,
      presence: true,
      length: { maximum: 500 }
    )
    validates(
      :product_model_id,
      presence: true,
      length: { maximum: 500 }
    )
    validates(
      :durability_loss,
      presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 100
      }
    )

  end

  class_methods do
  end
end
