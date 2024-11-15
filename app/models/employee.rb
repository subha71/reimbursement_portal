class Employee < ApplicationRecord
  belongs_to :company, counter_cache: :employee_count
  has_many :reimbursements
end
