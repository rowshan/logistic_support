require 'rails_helper'


RSpec.describe SchedulesController, type: :controller do
  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }


  describe "GET index" do
    let!(:schedules) { create_list :schedule, rand(2..10) }
    it "assigns all schedules as @schedules" do
      get :index, params: {}, session: valid_session
      expect(assigns(:schedules)).to eq(schedules)
    end
  end

  describe "GET show" do
    let!(:schedule) { create :schedule }
    it "assigns the requested schedule as @schedule" do
      get :show, params: {:id => schedule.to_param}, session: valid_session
      expect(assigns(:schedule)).to eq(schedule)
    end
  end

  describe "POST create" do
    let!(:shift) { create :shift }
    let!(:driver) { create :driver }

    describe "with valid params" do
      it "creates a new Schedule" do
        expect {
          post :create, params:{:shift_id=> shift.to_param,:driver_id=> driver.to_param}.merge(
              json_api_params(Schedule, attributes_for(:schedule).update(shift_id:shift.to_param,
                                                                      :driver_id=> driver.to_param))
          ), session: valid_session
        }.to change(Schedule, :count).by(1)
      end

      it "assigns a newly created schedule as @schedule" do
        post :create, params:{:shift_id=> shift.to_param}.merge(
            json_api_params(Schedule, attributes_for(:schedule).update(shift_id:shift.to_param,
                                                                    :driver_id=> driver.to_param))
        ), session: valid_session
        expect(assigns(:schedule)).to be_a(Schedule)
        expect(assigns(:schedule)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved schedule as @schedule" do
        post :create, params: {:shift_id=> shift.to_param}.merge(
            json_api_params(Schedule, attributes_for(:schedule)).update(date:nil)), session: valid_session
        expect(assigns(:schedule)).to be_a_new(Schedule)
      end
    end
  end


  describe "PUT update" do
    let!(:schedule) { create :schedule  }
    let(:new_attributes) { attributes_for(:schedule)}

    describe "with valid params" do
      it "updates the requested Schedule" do
        put :update, params: {:id => schedule.to_param}.update(
            json_api_params(Schedule, new_attributes)), session: valid_session
        schedule.reload
        new_attributes.slice(:date, :driver_id,:shift_id).each do |attr, val|
          expect(schedule.send(attr)).to eq(val)
        end

      end

      it "assigns the requested schedule as @schedule" do
        put :update, params: {:id => schedule.to_param}.update(
            json_api_params(Schedule, new_attributes)), session: valid_session
        expect(assigns(:schedule)).to eq(schedule)
      end
    end

    describe "with invalid params" do
      it "assigns the schedule as @schedule" do
        put :update, params: {:id => schedule.to_param}.update(
            json_api_params(Schedule, new_attributes.update(date:nil))), session: valid_session
        expect(assigns(:schedule)).to eq(schedule)
      end

    end
  end

  describe "DELETE destroy" do
    let!(:schedule) { create :schedule }
    it "destroys the requested schedule" do
      expect {
        delete :destroy, params: {:id => schedule.to_param}, session: valid_session
      }.to change(Schedule, :count).by(-1)
    end
  end

end
