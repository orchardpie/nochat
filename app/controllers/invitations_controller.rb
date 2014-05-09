class InvitationsController < ApplicationController
  respond_to :html

  skip_before_filter :authenticate_entity!
  before_filter :load_invitation

  def show
    @rsvp = Rsvp.new(invitation: @invitation, user: {})
    respond_with(@invitation)
  end

  private

  def load_invitation
    @invitation = Invitation.find_by_param!(params[:id])
  end
end

