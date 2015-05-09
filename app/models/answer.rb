class Answer < ActiveRecord::Base
  belongs_to :choice
  belongs_to :user
  belongs_to :question

  has_one :survey, through: :question

  scope :for_survey, -> (survey) {
    joins(:question).where('questions.survey_id = ?', survey.id)
  }
end
