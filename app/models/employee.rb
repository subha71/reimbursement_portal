class Employee < ApplicationRecord
  belongs_to :company, counter_cache: :employee_count
  has_many :reimbursements
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
end
