class TaxesController < ApplicationController
  def index
    monthly_income = params[:monthly_income] ? params[:monthly_income].gsub(',', '').to_i : 0
    salary_paid_for_insurance = params[:salary_paid_for_insurance] ? params[:salary_paid_for_insurance].gsub(',', '').to_i : 0
    number_dependents = params[:number_dependents] ? params[:number_dependents].gsub(',', '').to_i : 0
    @income_tax = TaxService::CalcPersonalIncomeTax.new.call(
      monthly_income: monthly_income,
      salary_paid_for_insurance: salary_paid_for_insurance,
      number_dependents: number_dependents
    )
  end
end
