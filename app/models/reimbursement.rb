class Reimbursement < ApplicationRecord
  belongs_to :employee
  has_one_attached :receipt

  validates :purpose, presence: true
  validates :amount, presence: true
  validates :date_of_expenditure, presence: true
  validate :date_of_expenditure_cannot_be_in_the_future

  def date_of_expenditure_cannot_be_in_the_future
    if date_of_expenditure.present? && date_of_expenditure > Date.today
      errors.add(:date_of_expenditure, "cannot be in the future")
    end
  end

end
