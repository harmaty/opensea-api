class OppositionsController < ApplicationController
  def show
    position = Position.find(params[:id])
    render json: position.search_oppositions
  end
end
