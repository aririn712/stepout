require 'rails_helper'

RSpec.describe "講座を開く", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course)
  end

  context '講座が開けるとき' do
    it 'ログインしたユーザーは講座を開ける' do
      # ログインする
      sign_in(@user)
      # 開講ページへのボタンがあることを確認する
      expect(page).to have_content('講座を開く')
      # 開講ページに移動する
      visit new_course_path
      # フォームに情報を入力する
      fill_in 'course-name', with: @course.title
      fill_in 'item-info-1', with: @course.text_1
      select 'プログラミング', from: 'course-category'
      select '0.5時間未満', from: 'course-hour'
      select 'PC', from: 'course-machine'
      select '早朝', from: 'course-time-zone'
      fill_in 'course-price', with: @course.price
      # 送信するとCouseモデルのカウントが1上がることを確認るる
      expect{
        find('input[name="commit"]').click
      }.to change { Course.count }.by(1)
      # ユーザーページに遷移することを確認する
      expect(current_path).to eq("/users/#{@user.id}")
      # ユーザーページに先ほど開講した講座が存在することを確認する
      expect(page).to have_content(@course.title)
    end
  end

  context '講座が開けないとき' do
    it 'ログインしていないと講座を開けない' do
      # 開講ページに移動しようとする
      visit new_course_path
      # ログインページに遷移してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '講座詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course)
  end
  
  context '詳細が見れる時' do
    it 'ログインしたユーザーは詳細を見れる' do
      # ログインする
      sign_in(@user)
      # ＠courseのユーザーページを訪れる
      visit "/users/#{@course.user.id}"
      # @courseの講座がユーザーページにあることを確認する
      expect(page).to have_content(@course.title)
      # @course.titleを押すとの講座詳細画面に遷移すしたことを確認する
      find_link(@course.title, href: course_path(@course)).click
      expect(current_path).to eq(course_path(@course))
      # @courseの詳細画面に@courseの内容があることを確認する
      expect(page).to have_content(@course.title)
    end
  end
  
  context '詳細が見れない時' do
    it 'ログインしていなければ詳細を見れない' do
      # ＠courseのユーザーページを訪れる
      visit "/users/#{@course.user.id}"
      # # @courseの講座がユーザーページにあることを確認する
      expect(page).to have_content(@course.title)
      # @course.titleを押すとのログイン画面に遷移すしたことを確認する
      find_link(@course.title, href: course_path(@course)).click
      expect(current_path).to eq(new_user_session_path)
    end
  end

end

RSpec.describe '講座を編集する', type: :system do
  before do
    @course1 = FactoryBot.create(:course)
    @course2 = FactoryBot.create(:course)
  end

  context '講座を編集できる時' do
    it 'ユーザーは自分が開いた講座を編集することができる' do
      # @course講座を開いたアカウントでログインする
      visit new_user_session_path
      fill_in 'email', with: @course1.user.email
      fill_in 'password', with: @course1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 開いた講座の詳細画面に遷移する
      visit course_path(@course1.id)
      # 詳細画面に編集ボタンがあることを確認する
      expect(page).to have_content('講座の編集')
      # 編集画面に遷移する
      visit edit_course_path(@course1.id)
      # すでに開講された講座の情報が入っている
      expect(page).to have_content(@course1.title)
      # 編集する
      fill_in 'course-name', with: '編集完了'
      # 編集してもCourseモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Course.count }.by(0)
      # 講座詳細画面に遷移することを確認する
      expect(current_path).to eq(course_path(@course1.id))
      # 詳細画面に先ほど編集した内容が存在することを確認する
      expect(page).to have_content(@course1.title)
    end
  end

  context '講座を編集できない時' do
    it 'ユーザーは他人が開いた講座を編集することができない' do
      # @course講座を開いたアカウントでログインする
      visit new_user_session_path
      fill_in 'email', with: @course1.user.email
      fill_in 'password', with: @course1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @course2の項の講座の編集画面に遷移しようとする
      visit edit_course_path(@course2.id)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
    end
    it 'ログインしていなければ編集画面に遷移できない' do
      # @course2の項の講座に遷移しようとする
      visit course_path(@course2.id)
      # ログインページに遷移してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '講座を削除する', type: :system do
  before do
    @course1 = FactoryBot.create(:course)
    @course2 = FactoryBot.create(:course)
  end

  context '講座を削除できる時' do
    it 'ユーザーは自分が開いた講座を削除することができる' do
      # @course講座を開いたアカウントでログインする
      visit new_user_session_path
      fill_in 'email', with: @course1.user.email
      fill_in 'password', with: @course1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 開いた講座の詳細画面に遷移する
      visit course_path(@course1.id)
      # 詳細画面に削除ボタンがあることを確認する
      expect(page).to have_content('講座を削除')
      # 削除するとCourseモデルのカウントが1減る
      expect{
        find_link('講座を削除', href: course_path(@course1)).click
      }.to change { Course.count }.by(-1)
      # ユーザーページに遷移したことを確認する
      expect(current_path).to eq("/users/#{@course1.user.id}")
    end
  end

  context '講座を削除できない時' do
    it 'ユーザーは他人が開いた講座を削除することができない' do
      # @course講座を開いたアカウントでログインする
      visit new_user_session_path
      fill_in 'email', with: @course1.user.email
      fill_in 'password', with: @course1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @course2の講座の削除ボタンがないことを確認する
      expect(page).to have_no_content('講座を削除')
    end
    it 'ログインしていなければ削除できない' do
      # @course2の項の講座に遷移しようとする
      visit course_path(@course2.id)
      # ログインページに遷移してしまったことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end