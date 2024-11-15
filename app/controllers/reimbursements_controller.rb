class ReimbursementsController < ApplicationController

  def new
    @reimbursement = Reimbursement.new
  end

  def create
    employee = Employee.find_by(id: reimbursement_params[:employee_id])
    @reimbursement = employee.reimbursements.new(reimbursement_params)
    if @reimbursement.save
      company = employee.company
      company.reimbursement_total += @reimbursement.amount
      if company.save
        redirect_to reimbursements_path, notice: 'Reimbursement was successfully created.'
      else
        render :new
      end
    else
      render :new
    end
  end

  def index
    @companies = Company.all
    conditions = []
    conditions << ["employees.company_id = '#{params[:company_id]}' "] if params[:company_id].present?
    conditions << ["employees.email ILIKE '%#{params[:email]}%' "] if params[:email].present?
    @reimbursements = Reimbursement.includes(employee: :company).with_attached_receipt.joins(:employee).where(conditions.join(' AND ')).order('created_at desc').page(params[:page]).per(10)
  end


  private

  def reimbursement_params
    params.require(:reimbursement).permit(:purpose, :amount, :date_of_expenditure, :receipt, :employee_id)
  end

end
