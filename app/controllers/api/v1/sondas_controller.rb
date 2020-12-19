class Api::V1::SondasController < ApplicationController
  before_action :set_sonda, only: [:show]

  def show
  end

  private
  def set_sonda
    @sonda = Sonda.find(params[:id])
  end

end
