require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'factory' do
    it 'exists' do
      expect { FactoryGirl.build :plant }.not_to raise_error
    end

    it 'is valid' do
      expect(build :plant).to be_valid
    end

    it 'has the attributes' do
      expect(attributes_for(:plant)).to include(:company, :email, :phone_no, :address, :tenant_id)
    end
  end


  describe "validation of" do

    context 'Company' do
      subject { build(:plant, company: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:company)
      end
    end

    context 'Email' do
      subject { build(:plant, email: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:email)
      end
    end

    context 'Phone Number' do
      subject { build(:plant, phone_no: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:phone_no)
      end
      end

    context 'Address' do
      subject { build(:plant, address: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:address)
      end
    end
    context 'tenant_id' do
      subject { build(:plant, tenant_id: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:tenant_id)
      end
    end

  end
end