require 'csv'

module Admin
  class CrossChecksController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = CrossCheck.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   CrossCheck.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def export
      send_data export_csv, filename: "cross-check-#{cross_check.id}.csv"
    end

    private

    def export_csv
      CSV.generate(headers: true) do |csv|
        csv << export_attrs.map(&:to_s).map(&:titleize)
        csv << export_attrs.map { |attr| cross_check.send(attr) }
      end
    end

    def cross_check
      @cross_check ||= requested_resource.decorate
    end

    def export_attrs
      CrossCheckDashboard::SHOW_PAGE_ATTRIBUTES
    end
  end
end
