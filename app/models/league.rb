class League < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :matches, dependent: :destroy
end
