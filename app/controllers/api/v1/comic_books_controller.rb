module Api
  module V1
    class ComicBooksController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @comic_books = ComicBook.all
        render :index, status: 201
      end

      def show
        @comic_book = ComicBook.find(params[:id])
        render :show, status: 201
      end

      def create
        @comic_book = ComicBook.new(comic_book_params)
        if @comic_book.save
          render :show, status: 201
        else
          render :fail, status: 422
        end
      end

      def update
        @comic_book = ComicBook.find(params[:id])
        if @comic_book.update_attributes(comic_book_params)
          render :show, status: 201
        else
          render :fail, status: 422
        end
      end

      def destroy
        @comic_book = ComicBook.find(params[:id])
        if @comic_book.destroy)
          render :show, status: 201
        else
          render :fail, status: 422
        end
      end

      private
      def comic_book_params
        params.require(:comic_book).permit(:title, :cover_number, :image)
      end
    end
  end
end
