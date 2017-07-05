require "rails_helper"

describe Admin::ApplicationController do
  let(:user) { create :user }
  let(:admin) { create :admin }

  describe "allowed user levels" do
    def expect_allowed(level, expected_to_be_allowed)
      case level
      when :admin then  login_user(admin)
      when :member then login_user(user)
      else              logout_user
      end

      get :index

      if expected_to_be_allowed
        expect(response.status).to eq 200
      else
        expect(response).to redirect_to new_sessions_path
      end
    end

    context "actions that don't specify an allowed user level" do
      controller do
        def index
          head :ok
        end
      end

      it "only lets admins in" do
        expect_allowed :admin, true
        expect_allowed :member, false
        expect_allowed :guest, false
      end
    end
  end
end
