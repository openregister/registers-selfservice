class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      NotifyMailer.api_key_confirmation(@user).deliver_later
      NotifyMailer.new_api_key_request(@user).deliver_later
      #TODO Mock out Google Auth for end-to-end tests
      AnalyticsUpdateService.new.add_new_service(@user[:api_key], @user[:department], @user[:service]) unless Rails.env.test?
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

private

  def user_params
    params.permit(:email, :service, :department, :api_key)
  end
end
