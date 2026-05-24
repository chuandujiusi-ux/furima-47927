class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  validates :user_id, :item_id, :city, :addresses, :token, presence: true

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
