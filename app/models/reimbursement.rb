class Reimbursement < ApplicationRecord
  belongs_to :employee
  has_one_attached :receipt
end
