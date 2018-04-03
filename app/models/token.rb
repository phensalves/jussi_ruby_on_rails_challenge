class Token < ActiveRecord::Base
  validates :token, presence: true
end