require 'rails_helper'

RSpec.describe TripKind, type: :model do

  describe 'factory' do
    it 'exists' do
      expect { FactoryGirl.build :trip_kind }.not_to raise_error
    end

    it 'is valid' do
      expect(build :trip_kind).to be_valid
    end

    it 'has the attributes' do
      expect(attributes_for(:trip_kind)).to include(:name, :description)
    end
  end

  describe "validation of" do

    context 'Name' do
      subject { build(:trip_kind, name:nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:name)
      end
    end

  end
end
