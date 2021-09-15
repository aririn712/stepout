require 'rails_helper'

RSpec.describe Course, type: :model do
  before do
    @course = FactoryBot.build(:course)
    @course.image = fixture_file_upload('app/assets/images/22116720_s.jpg')
  end

  describe '講座を開く' do
    context '講座が開ける時' do
      it 'image,title,text_1,text_2,text_3,text_4,category_id,hour_id,machine_id,other_machiine,time_zone_id,priceが存在すれば出品できる' do
        expect(@course).to be_valid
      end
      it 'priceが半角数字の100~99999の間のとき出品できる' do
        @course.price = 300
        expect(@course).to be_valid
      end
      it 'imageがなくても出品できる' do
        @course.image = nil
        expect(@course).to be_valid
      end
      it 'text_2がなくても出品できる' do
        @course.text_2 = ''
        expect(@course).to be_valid
      end
      it 'text_3がなくても出品できる' do
        @course.text_3 = ''
        expect(@course).to be_valid
      end
      it 'text_4がなくても出品できる' do
        @course.text_4 = ''
        expect(@course).to be_valid
      end
      it 'other_machineがなくても出品できる' do
        @course.other_machine = ''
        expect(@course).to be_valid
      end
    end

    context '講座が開けないとき' do
      it 'titleが空のとき出品できない' do
        @course.title = nil
        @course.valid?
        expect(@course.errors.full_messages).to include("Title can't be blank")
      end
      it 'text_1が空のとき出品できない' do
        @course.text_1 = nil
        @course.valid?
        expect(@course.errors.full_messages).to include("Text 1 can't be blank")
      end
      it 'category_idが1のとき出品できない' do
        @course.category_id = 1
        @course.valid?
        expect(@course.errors.full_messages).to include("Category can't be blank")
      end
      it 'hour_idが1のとき出品できない' do
        @course.hour_id = 1
        @course.valid?
        expect(@course.errors.full_messages).to include("Hour can't be blank")
      end
      it 'machine_idが1のとき出品できない' do
        @course.machine_id = 1
        @course.valid?
        expect(@course.errors.full_messages).to include("Machine can't be blank")
      end
      it 'time_zone_idが1のとき出品できない' do
        @course.time_zone_id = 1
        @course.valid?
        expect(@course.errors.full_messages).to include("Time zone can't be blank")
      end
      it 'priceが100未満の時出品できない' do
        @course.price = 99
        @course.valid?
        expect(@course.errors.full_messages).to include('Price must be greater than or equal to 100')
      end
      it 'priceが99999より大きい時出品できない' do
        @course.price = 100_000
        @course.valid?
        expect(@course.errors.full_messages).to include('Price must be less than or equal to 99999')
      end
      it 'priceが英語の時出品できない' do
        @course.price = 'aaaaaa'
        @course.valid?
        expect(@course.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角英数混合の時出品できない' do
        @course.price = '1111a'
        @course.valid?
        expect(@course.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが全角の時出品できない' do
        @course.price = '３００'
        @course.valid?
        expect(@course.errors.full_messages).to include('Price is not a number')
      end
      it 'ユーザーが紐付いていなければ出品できない' do
        @course.user = nil
        @course.valid?
        expect(@course.errors.full_messages).to include('User must exist')
      end
    end
  end
end
