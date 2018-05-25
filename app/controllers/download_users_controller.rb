class DownloadUsersController < ApplicationController
  def create
    @download_user = DownloadUser.new(download_user_params)

    if @download_user.save
      render json: @download_user, status: :created
      NotifyMailer.register_download_confirmation(@download_user).deliver_later
    else
      render json: @download_user.errors, status: :unprocessable_entity
    end
  end

private

  def download_user_params
    params.permit(:email, :non_gov_use_category, :department, :is_government, :register)
  end
end
