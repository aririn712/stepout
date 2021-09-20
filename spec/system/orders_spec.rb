require 'rails_helper'

RSpec.describe '受講を希望する', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course)
  end
  context '受講希望申請ができるとき' do
    it '＠course.user以外のアカウントでログインしていたらできる' do
      # @userでログインする
      sign_in(@user)
      # @courseの詳細ページに訪れる
      visit course_path(@course.id)
      # 詳細ページに受講を希望するボタンがあることを確認する
      expect(page).to have_content('受講を希望する')
      # 受講を希望するボタンを押すとOrderモデルのカウントが1増えることを確認する
      expect do
        find_link('受講を希望する', href: "/courses/#{@course.id}/orders").click
      end.to change { Order.count }.by(1)
      # 詳細ページに受講希望を取り消すボタンがあることを確認する
      expect(page).to have_content('受講希望を取り消す')
    end
  end

  context '受講希望申請ができないとき' do
    it '@course.userのアカウントでログインしていたらできない' do
      # @course.userでログインする
      visit new_user_session_path
      fill_in 'email', with: @course.user.email
      fill_in 'password', with: @course.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @courseの詳細ページに訪れる
      visit course_path(@course.id)
      # 詳細ページに受講を希望するボタンがないことを確認する
      expect(page).to have_no_content('受講を希望する')
    end
    it 'ログインしていなければできない' do
      # @courseの詳細ページに訪れる
      visit course_path(@course.id)
      # ログインページに遷移してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '受講希望を取り消す', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course)
    @user2 = FactoryBot.create(:user)
    @order = FactoryBot.create(:order, user_id: @user.id, course_id: @course.id)
  end
  context '受講希望申請取り消しができるとき' do
    it '＠orderのアカウントだと受講申請取り消しができる' do
      # @userでログインする
      sign_in(@user)
      # @courseの詳細ページに訪れる
      visit course_path(@course.id)
      # 詳細ページに受講希望を取り消すボタンがあることを確認する
      expect(page).to have_content('受講希望を取り消す')
      # 受講を希望するボタンを押すとOrderモデルのカウントが1減ることを確認する
      expect do
        find_link('受講希望を取り消す', href: "/courses/#{@course.id}/orders/#{@order.id}").click
      end.to change { Order.count }.by(-1)
      # 詳細ページに受講希望ボタンがあることを確認する
      expect(page).to have_content('受講を希望する')
    end
  end

  context '受講希望申請取り消しができない時' do
    it '@order.user以外のアカウントでログインした時' do
      # @user2でログインする
      sign_in(@user2)
      # @order.courseの詳細ページに訪れる
      visit course_path(@order.course.id)
      # 詳細ページに受講を希望するボタンがないことを確認する
      expect(page).to have_no_content('受講希望を取り消す')
    end
    it 'ログインしていなければできない' do
      # @courseの詳細ページに訪れる
      visit course_path(@order.course.id)
      # ログインページに遷移してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '受講生一覧', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course)
  end
  context '受講生一覧を見ることができる' do
    it '＠course.userだと見ることができる' do
      # @userで@courseを受講希望する
      sign_in(@user)
      visit course_path(@course.id)
      find_link('受講を希望する', href: "/courses/#{@course.id}/orders").click
      # ログアウトする
      find_link('ログアウト', href: destroy_user_session_path).click
      # @course.userでログインする
      visit new_user_session_path
      fill_in 'email', with: @course.user.email
      fill_in 'password', with: @course.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @courseの詳細ページに訪れる
      visit course_path(@course.id)
      # 詳細ページに受講希望者リストボタンがあることを確認する
      expect(page).to have_content('受講希望者リスト')
      # 受講希望者リストボタンを押すと受講希望者一覧画面に遷移したことを確認する
      find_link('受講希望者リスト', href: "/courses/#{@course.id}/orders/favorite").click
      expect(current_path).to eq("/courses/#{@course.id}/orders/favorite")
      # @user.nicknameがあることを確認する
      expect(page).to have_content(@user.nickname)
    end
  end

  context '受講生一覧を見ることができない' do
    it '@course.user以外のアカウントでは、見ることができない' do
      # @userで@courseを受講希望する
      sign_in(@user)
      visit course_path(@course.id)
      find_link('受講を希望する', href: "/courses/#{@course.id}/orders").click
      # @courseの詳細画面であることを確認する
      expect(current_path).to eq(course_path(@course.id))
      # 詳細画面に受講希望者リストボタンがないことを確認する
      expect(page).to have_no_content('受講希望者リスト')
    end
    it 'ログインしていなければできない' do
      # @userで@courseを受講希望する
      sign_in(@user)
      visit course_path(@course.id)
      find_link('受講を希望する', href: "/courses/#{@course.id}/orders").click
      # ログアウトする
      find_link('ログアウト', href: destroy_user_session_path).click
      # @courseの詳細ページに訪れる
      visit course_path(@course.id)
      # ログインページに遷移してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '受講希望している講座', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course)
    @user2 = FactoryBot.create(:user)
  end
  context '受講希望している講座を見ることができる' do
    it '自分が受講している講座なら見ることができる' do
      # 受講希望する
      sign_in(@user)
      visit course_path(@course.id)
      find_link('受講を希望する', href: "/courses/#{@course.id}/orders").click
      # 自分のユーザーページに遷移する
      visit "/users/#{@user.id}"
      # ユーザーページに受講希望したタイトルがあることを確認する
      expect(page).to have_content(@course.title)
    end
  end

  context '受講希望している講座を見ることができない' do
    it 'ログインしていても自分が受講していない講座は見ることができない' do
      # @userで受講希望する
      sign_in(@user)
      visit course_path(@course.id)
      find_link('受講を希望する', href: "/courses/#{@course.id}/orders").click
      # ログアウトする
      find_link('ログアウト', href: destroy_user_session_path).click
      # ＠user２でログインする
      sign_in(@user2)
      # @userのユーザーページに遷移する
      visit "/users/#{@user.id}"
      # ユーザーページに受講希望したタイトルがないことを確認する
      expect(page).to have_no_content(@course.title)
    end

    it 'ログインしていなければならない' do
      # @userで受講希望する
      sign_in(@user)
      visit course_path(@course.id)
      find_link('受講を希望する', href: "/courses/#{@course.id}/orders").click
      # ログアウトする
      find_link('ログアウト', href: destroy_user_session_path).click
      # @userのユーザーページに遷移する
      visit "/users/#{@user.id}"
      # ユーザーページに受講希望したタイトルがないことを確認する
      expect(page).to have_no_content(@course.title)
    end
  end
end
