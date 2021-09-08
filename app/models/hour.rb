class Hour < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '0.5時間未満' },
    { id: 3, name: '0.5~1時間' },
    { id: 4, name: '1~2時間' },
    { id: 5, name: '2時間以上' },
    { id: 6, name: '1日以上' }
  ]
  include ActiveHash::Associations
  has_many :courses
end
