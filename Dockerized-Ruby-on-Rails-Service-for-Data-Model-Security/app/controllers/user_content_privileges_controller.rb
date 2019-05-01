# frozen_string_literal: true

# UserContentPrivilegesController inherits from ApplicationController
class UserContentPrivilegesController < ApplicationController
  before_action only: [:index] do
    params.require(:client_id)
  end

  def index
    user_content_privileges = UserContentPrivilege.where(client_id: params[:client_id])
    render json: user_content_privileges
  end

  def show
    user_content_privilege = UserContentPrivilege.find_by!(id: params[:id])
    render json: user_content_privilege
  end

  def create
    user_content_privilege = UserContentPrivilege.create!(user_content_privilege_params)
    render json: user_content_privilege, status: :created
  end

  def destroy
    user_content_privilege = UserContentPrivilege.find_by!(id: params[:id])
    user_content_privilege.destroy
    head :no_content
  end

  def update
    user_content_privilege = UserContentPrivilege.find_by!(id: params[:id])
    user_content_privilege.update_attributes!(user_content_update_params)
    head :no_content
  end

  private

  def user_content_privilege_params
    params.permit(:role, :content_id, :user_grouping_type, :user_grouping_id, :client_id)
  end

  def user_content_update_params
    params.permit(:role, :content_id, :user_grouping_type, :user_grouping_id)
  end
end
