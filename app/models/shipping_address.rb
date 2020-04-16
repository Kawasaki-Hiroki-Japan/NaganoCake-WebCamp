class ShippingAddress < ApplicationRecord
  validates :end_user_id, presence: true
  validates :name, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true

  belongs_to :end_user
end
