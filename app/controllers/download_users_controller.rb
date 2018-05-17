class DownloadUsersController < ApplicationController
  def create
    @download_user = DownloadUser.new(download_user_params)

    if @download_user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

private

  def download_user_params
    params.permit(:email, :non_gov_use_category, :department, :is_government, :register)
  end
end
