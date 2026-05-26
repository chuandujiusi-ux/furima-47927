class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :postage_payer
  belongs_to :prefecture
  belongs_to :preparation_day
  belongs_to :user

  # ⭕ コントローラーの NameError を一発で消し去るための必須アソシエーション
  has_one :order

  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  with_options numericality: { other_than: 1, message: "を入力してください" } do
    validates :category_id
    validates :item_condition_id
    validates :postage_payer_id
    validates :prefecture_id
    validates :preparation_day_id
  end
end
