class TimeZone < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '早朝' },
    { id: 3, name: '午前' },
    { id: 4, name: '午後' },
    { id: 5, name: '夕方' },
    { id: 6, name: '午前0時前' },
    { id: 7, name: '午前0時以降' },
  ]
  include ActiveHash::Associations
  has_many :courses
end