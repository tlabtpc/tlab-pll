module Admin
  class AssessmentsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Assessment.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def requested_resource
      super.decorate
    end
  end
end
