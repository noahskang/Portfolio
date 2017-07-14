class Api::PokemonController < ApplicationController

  def index
    @pokemon = Pokemon.all
  end

  def show
    @poke = Pokemon.find(params[:id])
  end

  def create
    @poke = Pokemon.create(poke_params)
    redirect_to root_url
  end

  private
  def poke_params
    params.require(:pokemon).permit(:name, :attack, :defense, :poke_type, :moves, :image_url)
  end
end
