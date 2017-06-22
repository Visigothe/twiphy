class GiphyController < ApplicationController
  def index
    @gifs = if params[:giphy]
      GiphyService.search(giphy_params[:q])
    end
  end

  private

  def giphy_params
    params.require(:giphy).permit(:q)
  end
end
