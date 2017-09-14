class HomeController < ApplicationController

  before_action :authenticate_user!

  def index
    @organization = current_user.organization
    @sensors = @organization.sensors
  end

end
