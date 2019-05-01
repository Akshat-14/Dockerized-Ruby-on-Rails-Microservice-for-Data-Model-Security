# frozen_string_literal: true

# ApplicationController inherits from ActionController
class ExternalUserGroupsController < ApplicationController
  def index
    external_user_groups = ExternalUserGroup.order('created_at DESC')
    render json: external_user_groups
  end

  def show
    external_user_group = ExternalUserGroup.find_by!(id: params[:id])
    render json: external_user_group
  end

  def create
    external_user_group = ExternalUserGroup.create!(external_user_group_params)
    render json: external_user_group, status: :created
  end

  def destroy
    external_user_group = ExternalUserGroup.find_by!(id: params[:id])
    external_user_group.destroy!
    head :no_content
  end

  def update
    external_user_group = ExternalUserGroup.find_by!(id: params[:id])
    external_user_group.update_attributes!(external_user_update_params)
    head :no_content
  end

  private

  def external_user_group_params
    params.permit(:name, :role, :source_group_id, :content_id, :external_application_id,:client_id)
  end

  def external_user_update_params
    params.permit(:name, :role, :source_group_id, :content_id, :external_application_id)
  end
end
