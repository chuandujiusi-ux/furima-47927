require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品ができるとき' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      # --- 基本情報 ---
      it '商品画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image を入力してください')
      end

      it '商品名が空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Name を入力してください')
      end

      it '商品の説明が空では出品できない' do
        @item.introduction = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Introduction を入力してください')
      end

      # --- ActiveHash (初期値1のとき) ---
      it 'カテゴリーの情報が「---」だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態の情報が「---」だと出品できない' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end

      it '配送料の負担の情報が「---」だと出品できない' do
        @item.postage_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage payer can't be blank")
      end

      it '発送元の地域の情報が「---」だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数の情報が「---」だと出品できない' do
        @item.preparation_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Preparation day can't be blank")
      end

      # --- 価格 ---
      it '価格が空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Price を入力してください')
      end

      it '価格が ¥300 未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors[:price]).to_not be_empty
      end

      it '価格が ¥9,999,999 より大きいと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors[:price]).to_not be_empty
      end

      it '価格に全角文字が含まれていると出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors[:price]).to_not be_empty
      end

      # --- ユーザー紐付け ---
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors[:user]).to_not be_empty
      end
    end
  end
end
