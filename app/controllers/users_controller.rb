class UsersController < ApplicationController
  respond_to :json

  before_action :load_user

  def show
    respond_with(@user)
  end

  private

  def load_user
    @user = User.find_by_param!(params[:id])
    raise ActiveRecord::RecordNotFound unless @user == current_user
  end
end

