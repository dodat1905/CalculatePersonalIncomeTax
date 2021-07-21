module TaxService
  class CalcPersonalIncomeTax
    CALC_SELF_REDUCTION = 11_000_000.freeze

    def call(args = {})
      social_insurance_calc = args[:salary_paid_for_insurance] * 8 / 100
      health_insurance_calc = args[:salary_paid_for_insurance] * 1.5 / 100
      unemployment_insurance_calc = args[:salary_paid_for_insurance] * 1 / 100
      compulsory_insurance_calc = social_insurance_calc + health_insurance_calc + unemployment_insurance_calc
      calc_dependent_reduction = args[:number_dependents] * 4_400_000
      income_taxes = args[:monthly_income] - compulsory_insurance_calc - CALC_SELF_REDUCTION - calc_dependent_reduction

      return 0 if income_taxes <= 0

      calc_applicable_tax_rate(income_taxes.to_i)
    end

    private

    def calc_applicable_tax_rate(income_taxes)
      case income_taxes
      when 0..5_000_000
        (income_taxes * 5 / 100)
      when 5_000_000..10_000_000
        (income_taxes * 10 / 100) - 250_000
      when 10_000_000..18_000_000
        (income_taxes * 15 / 100)  - 750_000
      when 18_000_000..32_000_000
        (income_taxes * 20 / 100)  - 1_650_000
      when 32_000_000..52_000_000
        (income_taxes * 25 / 100)  - 3_250_000
      when 52_000_000..80_000_000
        (income_taxes * 30 / 100)  - 5_850_000
      else
        (income_taxes * 35 / 100)  - 9_850_000
      end
    end
  end
end
