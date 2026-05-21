class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :category
  belongs_to :item_condition
  belongs_to :postage_payer
  belongs_to :prefecture
  belongs_to :preparation_day

  belongs_to :user
  has_one_attached :image

  validates :image,             presence: true
  validates :name,              presence: true
  validates :introduction,      presence: true
  validates :price,             presence: true

  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_payer_id,   numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :preparation_day_id, numericality: { other_than: 1, message: "can't be blank" }

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
