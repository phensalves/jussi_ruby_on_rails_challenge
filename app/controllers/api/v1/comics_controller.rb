class Api::V1::ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :update, :destroy]

  def index
    comics = Comic.all
    render json: comics
  end

  def show
    if @comic
      render json: @comic
    else
      render json: { message: "Not found" }, status: 404
    end
  end

  def create
    comic = Comic.new(comic_params)
    if comic.save
      render json: comic, status: 201
    else
      render json: { errors: comic.errors }, status: 422
    end
  end

  def update
    if @comic.update_attributes(comic_params)
      render json: @comic, status: 200
    else
      render json: { errors: @comic.errors }, status: 422
    end
  end

  def destroy
    if @comic.destroy
      head 204
    end
  end

  private

  def set_comic
    begin
      @comic = Comic.find(params[:id])
    rescue
      nil
    end
  end

  def comic_params
    params.require(:comic).permit(:title, :cover_number, :image)
  end
end
