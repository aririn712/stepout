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
      fill_in '例) test太郎', with: @user.nickname
      fill_in 'PC・携帯どちらでも可', with: @user.email
      fill_in 'password', with: @user.password
      fill_in '同じパスワードを入力して下さい', with: @user.password_confirmation
      fill_in '例) 〇〇です。よろしくお願いします！', with: @user.profile
      # 新規登録ボタンを押すと、ユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # ログインページに移動してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
      # ログインページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '例) test太郎', with: ''
      fill_in 'PC・携帯どちらでも可', with: ''
      fill_in '6文字以上の半角英数字', with: ''
      fill_in '同じパスワードを入力して下さい', with: ''
      fill_in '例) 〇〇です。よろしくお願いします！', with: ''
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページに戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # ログインページに移動してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
      # 正しいユーザー情報を入力する
      fill_in 'PC・携帯どちらでも可', with: @user.email
      fill_in '6文字以上の半角英数字', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # ログインページに移動してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
      # ユーザー情報を入力する
      fill_in 'PC・携帯どちらでも可', with: ''
      fill_in '6文字以上の半角英数字', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'ユーザーページ', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  it 'ログインいているとユーザーページに訪れることができる' do
    # ログインする
    sign_in(@user1)
    # @user2のユーザーページに遷移する
    visit "/users/#{@user2.id}"
    # @user2のユーザーページに遷移できたことを確認する
    expect(current_path).to eq("/users/#{@user2.id}")
  end
  it 'ログインしていなくてもユーザーページに訪れることができる' do
    # @user2のユーザーページに遷移する
    visit "/users/#{@user2.id}"
    # @user2のユーザーページに遷移できたことを確認する
    expect(current_path).to eq("/users/#{@user2.id}")
  end
end
