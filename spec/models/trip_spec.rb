require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:trip) { FactoryGirl.create :trip }

  describe 'factory' do
    it 'exists' do
      expect { FactoryGirl.build :trip }.not_to raise_error
    end

    it 'is valid' do
      expect(build :trip).to be_valid
    end

    it 'has the attributes' do
      expect(attributes_for(:trip)).to include(:trip_kind_id, :order_id, :date, :time_window_id, :address_id)
    end
  end


  describe "validation of" do

    context 'trip_kind_id' do
      subject { build(:trip, trip_kind_id: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:trip_kind_id)
      end
    end

    context 'trip_kind_id' do
      subject { build(:trip, order_id: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:order_id)
      end
    end

    context 'trip_kind_id' do
      subject { build(:trip, time_window_id: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:time_window_id)
      end
    end

    context 'trip_kind_id' do
      subject { build(:trip, address_id: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:address_id)
      end
    end
  end

  context 'uniqueness of ' do
    {
        trip_kind_id: SecureRandom.uuid
    }.each do |field, value|
      context "#{field}" do
        it 'fails for identical' do
          trip.attributes.dup
          trip.valid?
          expect(trip.errors[field].size).to eq(0)
        end

        it 'passes for different' do
          trip.attributes.dup
          trip.send(:"#{field}=", value)
          trip.valid?
          expect(trip.errors[field].size).to eq(0)
        end
      end
    end
  end


end


