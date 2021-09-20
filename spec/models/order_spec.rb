require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    course = FactoryBot.build(:course)
    course.save
    @order = FactoryBot.build(:order, course_id: course.id)
  end

  describe '受講申請' do
    context '申請できる時' do
      it '紐付けできてる時' do
        expect(@order).to be_valid
      end
    end

    context '申請できない時' do
      it 'user_idが空だと申請できないこと' do
        @order.user = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('User must exist')
      end
      it 'course_idが空だと申請できないこと' do
        @order.course_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('Course must exist')
      end
    end
  end
end
