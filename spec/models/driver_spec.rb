require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe 'factory' do
    it 'exists' do
      expect { FactoryGirl.build :driver }.not_to raise_error
    end

    it 'is valid' do
      expect(build :driver).to be_valid
    end

    it 'has the attributes' do
      expect(attributes_for(:driver)).to include(:first_name, :last_name, :enabled)
    end
  end


  describe "validation of" do

    context 'first_name' do
      subject { build(:driver, first_name: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:first_name)
      end
    end

    context 'last_name' do
      subject { build(:driver, last_name: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:last_name)
      end
    end

    context 'plant_id' do
      subject { build(:driver, plant_id: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:plant_id)
      end
    end
  end
end
