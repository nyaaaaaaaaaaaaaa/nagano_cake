class Order < ApplicationRecord
  has_one_attached :image

  has_many :order_details

  belongs_to :customer

  default_scope -> { order(created_at: :desc) }

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting: 0, confirm: 1, creating: 2, preparing: 3, shipped: 4 }
end
