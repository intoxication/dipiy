class DevicesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @device = current_user.devices.find(params[:id])
    @device.delete
    redirect_to oauth_applications_path, notice: "Device information has been deleted"
  end
end
