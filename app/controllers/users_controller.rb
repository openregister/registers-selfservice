class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      #TODO Mock out Google Auth for end-to-end tests
      AnalyticsUpdateService.new.add_new_service(@user[:api_key], @user.department_name, @user[:non_gov_use_category], @user[:is_government]) unless Rails.env.test?
      render json: @user, status: :created
      if @user.email.present?
        NotifyMailer.api_key_confirmation(@user).deliver_later
        NotifyMailer.new_api_key_request(@user).deliver_later
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

private

  def user_params
    params.permit(:email, :non_gov_use_category, :department, :api_key, :is_government, :contactable)
  end
end
