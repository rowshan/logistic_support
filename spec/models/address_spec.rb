require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'factory' do

    it 'exists' do
      expect { build(:address) }.not_to raise_error
    end


    it 'is valid' do
      expect(build(:address)).to be_valid
    end
  end

  describe 'validation of' do

    let!(:address) { build :address }

    context 'presence of' do
      {
          first_name: "First #{Time.now.to_i}", last_name: "Last #{Time.now.to_i}",
          street: "Street#{Time.now.to_i}", house_no_main: rand(2000).to_s,
          postal_code_id: SecureRandom.uuid, postal_code: %w(1010 1020 1060).sample,
          city_id: SecureRandom.uuid, city: 'Vienna',
          country_id: SecureRandom.uuid, country_code: 'AT', country: 'Austria'
      }.each do |field, value|
        context "#{field}" do
          it 'fails without' do
            address.send(:"#{field}=", nil)
            address.valid?
            expect(address.errors[field].size).to be > 0
          end

          it 'passes with' do
            address.send(:"#{field}=", value)
            address.valid?
            expect(address.errors[field].size).to eq(0)
          end
        end
      end
    end
  end
end
