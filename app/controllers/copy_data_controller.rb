class CopyDataController < ApplicationController
  def index
    MarvelWorker.perform_async

    render html: "done!"
  end
end
