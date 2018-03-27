class MarvelApiWorker < ApplicationJob
  queue_as :marvel_api_consume

  def perform
    MarvelApiConsume.new.start
  end
end
