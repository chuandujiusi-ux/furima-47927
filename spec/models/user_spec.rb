require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      # ニックネーム・メールアドレス
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors[:nickname]).to_not be_empty
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to_not be_empty
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to_not be_empty
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors[:email]).to_not be_empty
      end

      # パスワード
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors[:password]).to_not be_empty
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors[:password]).to_not be_empty
      end

      it 'passwordが英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors[:password]).to_not be_empty
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors[:password]).to_not be_empty
      end

      it 'passwordに全角文字が含まれると登録できない' do
        @user.password = '1a３４５６'
        @user.password_confirmation = '1a３４５６'
        @user.valid?
        expect(@user.errors[:password]).to_not be_empty
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = 'different123'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to_not be_empty
      end

      # 本人情報（名字・名前）
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to_not be_empty
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to_not be_empty
      end

      it 'last_nameが半角文字では登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors[:last_name]).to_not be_empty
      end

      it 'first_nameが半角文字では登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors[:first_name]).to_not be_empty
      end

      # 本人情報（カナ）
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to_not be_empty
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to_not be_empty
      end

      it 'last_name_kanaがカタカナ以外（ひらがななど）では登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to_not be_empty
      end

      it 'first_name_kanaがカタカナ以外（ひらがななど）では登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to_not be_empty
      end

      # 生年月日
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors[:birthday]).to_not be_empty
      end
    end
  end
end
