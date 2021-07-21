require 'rails_helper'

RSpec.describe TaxService::CalcPersonalIncomeTax do
  describe '#call' do
    let(:service) { described_class.new }

    it 'when calculation of personal income tax' do
      expect(service.call({ monthly_income: 30_000_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 0 })).to eq(2_057_180)
    end

    it 'when there is no need to pay personal income tax' do
      expect(service.call({ monthly_income: 10_000_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 0 })).to eq(0)
    end

    it 'when the number of dependents is greater than 0' do
      expect(service.call({ monthly_income: 20_000_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(206_795)
    end

    it 'When the taxable income is less than 5 million VND' do
      expect(service.call({ monthly_income: 4_500_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(0)
    end

    it 'When the taxable income is more than 5 million VND, less than 10 million VND' do
      expect(service.call({ monthly_income: 12_000_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(0)
    end

    it 'When the taxable income is more than 10 million VND, less than 18 million VND' do
      expect(service.call({ monthly_income: 14_000_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(0)
    end

    it 'When the taxable income is more than 18 million VND, less than 32 million VND' do
      expect(service.call({ monthly_income: 26_600_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(860_385)
    end

    it 'When the taxable income is more than 32 million VND, less than 52 million VND' do
      expect(service.call({ monthly_income: 40_000_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(3_177_180)
    end

    it 'When the taxable income is more than 52 million VND, less than 80 million VND' do
      expect(service.call({ monthly_income: 76_500_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(12_340_770)
    end

    it 'When the taxable income is more than 80 million VND' do
      expect(service.call({ monthly_income: 100_000_000,
                            salary_paid_for_insurance: 4_420_000,
                            number_dependents: 1 })).to eq(19_597_565)
    end
  end
end
