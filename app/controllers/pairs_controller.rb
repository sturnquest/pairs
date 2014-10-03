class PairsController < ApplicationController

  def show
    @@match_maker ||= MatchMaker.seed(JSON.load(IO.read(File.join(Rails.root, 'config', 'organization.json'))))

    pairs = @@match_maker.pairs(params[:id].to_i)

    render :json => pairs, :content_type => 'application/json'
  end

end
