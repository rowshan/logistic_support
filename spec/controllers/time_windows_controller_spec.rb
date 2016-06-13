require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TimeWindowsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # TimeWindow. As you add validations to TimeWindow, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TimeWindowsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all time_windows as @time_windows" do
      time_window = TimeWindow.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:time_windows)).to eq([time_window])
    end
  end

  describe "GET #show" do
    it "assigns the requested time_window as @time_window" do
      time_window = TimeWindow.create! valid_attributes
      get :show, {:id => time_window.to_param}, valid_session
      expect(assigns(:time_window)).to eq(time_window)
    end
  end

  describe "GET #new" do
    it "assigns a new time_window as @time_window" do
      get :new, {}, valid_session
      expect(assigns(:time_window)).to be_a_new(TimeWindow)
    end
  end

  describe "GET #edit" do
    it "assigns the requested time_window as @time_window" do
      time_window = TimeWindow.create! valid_attributes
      get :edit, {:id => time_window.to_param}, valid_session
      expect(assigns(:time_window)).to eq(time_window)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TimeWindow" do
        expect {
          post :create, {:time_window => valid_attributes}, valid_session
        }.to change(TimeWindow, :count).by(1)
      end

      it "assigns a newly created time_window as @time_window" do
        post :create, {:time_window => valid_attributes}, valid_session
        expect(assigns(:time_window)).to be_a(TimeWindow)
        expect(assigns(:time_window)).to be_persisted
      end

      it "redirects to the created time_window" do
        post :create, {:time_window => valid_attributes}, valid_session
        expect(response).to redirect_to(TimeWindow.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved time_window as @time_window" do
        post :create, {:time_window => invalid_attributes}, valid_session
        expect(assigns(:time_window)).to be_a_new(TimeWindow)
      end

      it "re-renders the 'new' template" do
        post :create, {:time_window => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested time_window" do
        time_window = TimeWindow.create! valid_attributes
        put :update, {:id => time_window.to_param, :time_window => new_attributes}, valid_session
        time_window.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested time_window as @time_window" do
        time_window = TimeWindow.create! valid_attributes
        put :update, {:id => time_window.to_param, :time_window => valid_attributes}, valid_session
        expect(assigns(:time_window)).to eq(time_window)
      end

      it "redirects to the time_window" do
        time_window = TimeWindow.create! valid_attributes
        put :update, {:id => time_window.to_param, :time_window => valid_attributes}, valid_session
        expect(response).to redirect_to(time_window)
      end
    end

    context "with invalid params" do
      it "assigns the time_window as @time_window" do
        time_window = TimeWindow.create! valid_attributes
        put :update, {:id => time_window.to_param, :time_window => invalid_attributes}, valid_session
        expect(assigns(:time_window)).to eq(time_window)
      end

      it "re-renders the 'edit' template" do
        time_window = TimeWindow.create! valid_attributes
        put :update, {:id => time_window.to_param, :time_window => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested time_window" do
      time_window = TimeWindow.create! valid_attributes
      expect {
        delete :destroy, {:id => time_window.to_param}, valid_session
      }.to change(TimeWindow, :count).by(-1)
    end

    it "redirects to the time_windows list" do
      time_window = TimeWindow.create! valid_attributes
      delete :destroy, {:id => time_window.to_param}, valid_session
      expect(response).to redirect_to(time_windows_url)
    end
  end

end
