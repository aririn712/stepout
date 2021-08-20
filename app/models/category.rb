class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'プログラミング' },
    { id: 3, name: 'ゲーム' },
    { id: 4, name: 'イラスト' },
    { id: 5, name: '音楽' },
    { id: 6, name: 'エクササイズ' },
    { id: 7, name: 'スポーツ' },
    { id: 8, name: '趣味' },
    { id: 9, name: '教育・教養' },
    { id: 10, name: 'ビジネススキル' },
    { id: 11, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :courses
end