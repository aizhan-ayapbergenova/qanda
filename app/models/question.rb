class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :attachments
  
  validates :title, :body, presence: true
end
