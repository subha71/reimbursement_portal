class EmployeesController < ApplicationController

  def index
    @companies = Company.all
    conditions = []
    conditions << ["employees.company_id = '#{params[:company_id]}' "] if params[:company_id].present?
    conditions << ["employees.email ilike '%#{params[:email]}%' "] if params[:email].present?
    @employees = Employee.includes(:company).where(conditions.join(' AND ')).page(params[:page]).per(10)
  end

  def new
    @employee = Employee.new
    @companies = Company.order(:name)
  end
  
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:notice] = "Company Successfully created"
      redirect_to employees_path
    else
      render :new
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :company_id)
  end
end
