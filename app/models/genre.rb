class Genre < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: [true, false] }

  has_many :items
end
