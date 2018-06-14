class DownloadUsersController < ApplicationController
  def create
    @download_user = User.new(user_params)
    @download_user.user_type = :download
    @download_user.contactable = true

    if @download_user.save
      render json: @download_user, status: :created
    else
      render json: @download_user.errors, status: :unprocessable_entity
    end
  end

private

  def user_params
    params.permit(:email, :non_gov_use_category, :department, :api_key, :is_government, :contactable, :register)
  end
end
