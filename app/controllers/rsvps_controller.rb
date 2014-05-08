class RsvpsController < ApplicationController
  respond_to :html

  skip_before_filter :authenticate_entity!
  before_filter :load_invitation

  def create
    @rsvp = Rsvp.create(rsvp_params.merge(invitation: @invitation))

    respond_with(@rsvp, location: new_user_session_path) do |format|
      format.html { render('invitations/show') } unless @rsvp.valid?
    end
  end

  private

  def load_invitation
    @invitation = Invitation.find_by_param!(params[:invitation_id])
  end

  def rsvp_params
    params.require(:rsvp).permit(user: :password)
  end
end

