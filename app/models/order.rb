class Order < ApplicationRecord
  validates :end_user_id, presence: true
  validates :name, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :pay_way, presence: true
  validates :postage, presence: true
  validates :total_price, presence: true
  validates :status, presence: true

  belongs_to :end_user
  has_many :order_items, dependent: :destroy
  enum pay_way: { "Credit Card": 1, "Bank": 2 }
  enum status: {
      "Unsettled": 0,
      "Waiting for payment": 1,
      "Payment confirmation": 2,
      "In production": 3,
      "Preparing for shipping": 4,
      "Sent": 5
    }
end
