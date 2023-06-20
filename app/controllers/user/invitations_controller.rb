class User::InvitationsController < Devise::InvitationsController
  layout 'slim', only: [:edit, :update]

  private

    # This is called when creating invitation.
    # It should return an instance of resource class.
    # def invite_resource
    #   # skip sending emails on invite
    #   super { |user| user.skip_invitation = true }
    # end

    # This is called when accepting invitation.
    # It should return an instance of resource class.

    def accept_resource
      resource = resource_class.accept_invitation!(update_resource_params)
      resource
    end

    def after_accept_path_for(resource)
      dashboard_path
    end
end