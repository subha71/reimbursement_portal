class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :employee_count, default: 0
      t.decimal :reimbursement_total, default: 0
      t.timestamps
    end
  end
end
