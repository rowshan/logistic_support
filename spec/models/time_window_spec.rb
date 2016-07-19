require 'rails_helper'

RSpec.describe TimeWindow, type: :model do
  describe 'factory' do
    it 'exists' do
      expect { FactoryGirl.build :time_window }.not_to raise_error
    end

    it 'is valid' do
      expect(build :time_window).to be_valid
    end

    it 'has the attributes' do
      expect(attributes_for(:time_window)).to include(:tenant_id,:label)
    end
  end



  describe "validation of" do

    context 'tenant_id' do
      subject { build(:time_window, tenant_id: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:tenant_id)
      end
    end

    context 'start_time' do
      subject { build(:time_window, start_time: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:start_time)
      end
    end

    context 'end_time' do
      subject { build(:time_window, end_time: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:end_time)
      end
    end

  end

end
