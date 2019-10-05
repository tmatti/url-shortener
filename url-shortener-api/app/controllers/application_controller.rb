# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError::StandardError, with: :unknown_failure
  rescue_from ActionController::ParameterMissing, with: :validation_failure
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :validation_failure

  def unknown_failure(err)
    error_response(500, :internal_server_error, err.message)
  end

  def not_found_error
    error_response(404, :not_found, 'Not found')
  end

  def validation_failure(err)
    error_response(400, :bad_request, err.message)
  end

  def route_not_found
    head 404
  end

  def success_response(status, body)
    render json: body, status: status
  end

  def error_response(code, status, message)
    render json: error_response_body(code, message), status: status
  end

  def error_response_body(code, message)
    { status: code, message: message }
  end
end
