class OrderDetail < ApplicationRecord
  has_one_attached :image

  belongs_to :order
  belongs_to :item

  enum making_status: { unstartable: 0, waiting: 1, creating: 2, completed: 3 }

end
