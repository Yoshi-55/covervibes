
class SongsController < ApplicationController
  def index
    service = SpotifySearchService.new
    tracks = service.random_search(1)
    @random_track = tracks.first
  end
end
