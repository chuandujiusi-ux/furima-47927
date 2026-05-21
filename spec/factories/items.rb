FactoryBot.define do
  factory :item do
    name { 'サッカーボール' }
    introduction { '最新のサッカーボールです' }
    category_id { 2 }
    item_condition_id { 2 }
    postage_payer_id { 2 }
    prefecture_id { 2 }
    preparation_day_id { 2 }
    price { 500 }

    association :user

    after(:build) do |item|
      item.image.attach(
        io: StringIO.new('dummy_image_content'),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
