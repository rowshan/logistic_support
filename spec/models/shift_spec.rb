require 'rails_helper'

RSpec.describe Shift, type: :model do

  describe 'factory' do
    it 'exists' do
      expect { FactoryGirl.build :shift }.not_to raise_error
    end

    it 'is valid' do
      expect(build :shift).to be_valid
    end

    it 'has the attributes' do
      expect(attributes_for(:shift)).to include(:name, :send_time, :enabled, :start_time, :end_time)
    end
  end


  describe "validation of" do
    context 'name' do
      subject { build(:shift, name: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:name)
      end
    end
    context 'start_time' do
      subject { build(:shift, start_time: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:start_time)
      end
    end
    context 'end_time' do
      subject { build(:shift, end_time: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:end_time)
      end
    end
    context 'Plant' do
      subject { build(:shift, plant: nil) }
      it " fails for missing" do
        expect(subject).not_to be_valid
        expect(subject.errors).to include(:plant)
      end
    end
  end
end
