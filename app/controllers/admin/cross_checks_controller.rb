require 'csv'

module Admin
  class CrossChecksController < Admin::ApplicationController
    def export
      send_data export_csv, filename: "cross-checks.csv"
    end

    def unprocessed
      index
    end

    private

    def export_csv
      raise "Invalid scope" unless ['all', 'unprocessed'].include?(params[:scope])
      CSV.generate(headers: true) do |csv|
        csv << CrossCheckDashboard::TITLE_MAP.values
        export_resources.find_each do |cross_check|
          csv << export_attrs.map { |attr| cross_check.decorate.send(attr) }
        end
      end.tap { export_resources.update_all(processed: true) }
    end

    def export_resources
      @export_resources ||= CrossCheck.send(params[:scope])
    end

    def requested_resource
      super.decorate
    end

    def cross_checks
      @cross_checks ||= resources.decorate
    end

    def export_attrs
      CrossCheckDashboard::SHOW_PAGE_ATTRIBUTES
    end
  end
end
