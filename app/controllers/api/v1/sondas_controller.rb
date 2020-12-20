class Api::V1::SondasController < ApplicationController
  before_action :set_sonda, only: [:show, :reset, :index]

  def index
    @sonda = Sonda.move(params[:commands])
  end
  def show

  end

  def reset
    @sonda.face = "E"
    @sonda.coordinate_x = @sonda.coordinate_y = 0
    @sonda.commands = []
    if @sonda.save!
      render json: {}, status: 204
    else
      render json: { errors: @sonda.errors}, status: 422
    end
  end

  private

  def set_sonda
    @sonda = Sonda.find(params[:id])
  end

end
