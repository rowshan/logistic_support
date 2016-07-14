require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'factory' do
    it 'exists' do
      expect { FactoryGirl.build :schedule }.not_to raise_error
    end

    it 'is valid' do
      expect(build :schedule).to be_valid
    end

    it 'has the attributes' do
      expect(attributes_for(:schedule)).to include(:date)
    end
  end


  describe "validation of" do
    context 'Date' do
      subject { build(:schedule, date: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:date)
      end
    end

    context 'Driver' do
      subject { build(:schedule, driver: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:driver)
      end
    end
    context 'Shift' do
      subject { build(:schedule, shift: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:shift)
      end
    end
  end
end
