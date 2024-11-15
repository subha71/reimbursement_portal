class ReimbursementsController < ApplicationController
  before_action :set_employee, only: [:create, :new]

  def new
    @reimbursement = @employee.reimbursements.new
  end

  def create
    @reimbursement = @employee.reimbursements.new(reimbursement_params)
    validate_file
    if @reimbursement.errors.any?
      render :new
      return
    end
    if @reimbursement.save
      company = @employee.company
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
    params.require(:reimbursement).permit(:purpose, :amount, :date_of_expenditure, :receipt)
  end

  def set_employee
    @employee = Employee.find_by(id: params[:employee_id])
  end

  def validate_file
    return if params[:reimbursement][:receipt].blank?
    file = params[:reimbursement][:receipt]
    unless ['image/png', 'image/jpeg', 'application/pdf'].include?(file.content_type)
      @reimbursement.errors.add(:receipt, 'must be a PNG, JPEG, or PDF')
    end
    if file.size > 5.megabytes
      @reimbursement.errors.add(:receipt, 'must be less than 5MB')
    end
  end

end
