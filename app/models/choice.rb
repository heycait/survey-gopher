class Choice < ActiveRecord::Base
  belongs_to :question

  has_one :survey, through: :question
end
