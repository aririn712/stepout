require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # ログインページに移動してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
      # ログインページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '例) ステップ太郎', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'PC・携帯どちらでも可', with: @user.password
      fill_in '6文字以上の半角英数字', with: @user.password_confirmation
      fill_in '例) 〇〇です。よろしくお願いします！', with: @user.profile
      # 新規登録ボタンを押すと、ユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end

  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      # ログインページに移動してしまったことを確認する
      # ログインページに新規登録ページへ遷移するボタンがあることを確認する
      # 新規登録ページに移動する
      # ユーザー情報を入力する
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      # 新規登録ページに戻ることを確認する
    end
  end
end
