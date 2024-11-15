class CreateReimbursements < ActiveRecord::Migration[7.2]
  def change
    create_table :reimbursements do |t|
      t.text :purpose
      t.decimal :amount   
      t.date :date_of_expenditure
      t.references :employee, null: false, foreign_key: true
      t.string :receipt

      t.timestamps
    end
  end
end
