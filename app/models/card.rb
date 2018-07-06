class Card < ApplicationRecord
  belongs_to :customer

  validates :numero, uniqueness: true, length: { is: 16 }
  validates :validade, presence: true
  validates :bandeira, presence: true
  validates :cvv, presence: true, length: { is: 3 }
  validates :titular, presence: true

end
