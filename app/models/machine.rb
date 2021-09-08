class Machine < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'PC' },
    { id: 3, name: 'PC(Windows対応のみ)' },
    { id: 4, name: 'Macbook' },
    { id: 5, name: 'タブレット' },
    { id: 6, name: 'ペンタブ' },
    { id: 7, name: 'スマートフォン' },
    { id: 8, name: 'Android' },
    { id: 9, name: 'iPhone' },
    { id: 11, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :courses
end
