class HomeController < ActionController::Base
  layout "layout"

  def index
    if !params[:keywords].nil? && !params[:keywords].empty?
      @offset = nil
      @total = Character.search(params[:keywords]).records.count
      @limit =   @total
      @characteres = Character.search(params[:keywords]).records
    else
      @offset = params[:page] || 0
      @total = Character.count
      @limit = 5
      @characteres = Character.page(@offset).per(@limit)
    end
  end

  def show
    @character = Character.find(params[:id])
  end
end
