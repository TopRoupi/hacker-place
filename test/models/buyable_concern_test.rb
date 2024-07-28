require "test_helper"

class BuyableConcernTest < ActiveSupport::TestCase
  test "should validade required attributes" do
    obj = build :mother_board

    assert obj.valid?

    obj.product_model_name = nil
    obj.valid?
    refute_empty obj.errors[:product_model_name]
    obj.product_model_name = "" * 201
    obj.valid?
    refute_empty obj.errors[:product_model_name]
    obj.product_model_name = "dwadwa dwadwa"
    obj.valid?
    assert_empty obj.errors[:product_model_name]

    obj.product_model_id = nil
    obj.valid?
    refute_empty obj.errors[:product_model_id]
    obj.product_model_id = "" * 201
    obj.valid?
    refute_empty obj.errors[:product_model_id]
    obj.product_model_id = "232332323232"
    obj.valid?
    assert_empty obj.errors[:product_model_id]

    obj.durability_loss = nil
    obj.valid?
    refute_empty obj.errors[:durability_loss]
    obj.durability_loss = -1
    obj.valid?
    refute_empty obj.errors[:durability_loss]
    obj.durability_loss = 101
    obj.valid?
    refute_empty obj.errors[:durability_loss]
    obj.durability_loss = 0.0001
    obj.valid?
    assert_empty obj.errors[:durability_loss]
  end
end
