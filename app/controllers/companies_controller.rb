class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = "Company Successfully created"
      redirect_to companies_path
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

end
