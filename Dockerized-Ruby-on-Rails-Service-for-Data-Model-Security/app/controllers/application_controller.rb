# frozen_string_literal: true

# ApplicationController inherits from ActionController
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_appropriate_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_appropriate_response

  def render_appropriate_response(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
