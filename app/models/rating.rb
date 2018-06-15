class Rating < ApplicationRecord
  belongs_to :business
  belongs_to :customer
end
