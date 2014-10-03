class PairsController < ApplicationController

  def show
    @@match_maker ||= MatchMaker.seed(JSON.load(IO.read(File.join(Rails.root, 'config', 'organization.json'))))

    logger.info("emails: #{@@match_maker.emails.inspect}")

    pairs = @@match_maker.pairs(params[:id].to_i)

    logger.info("pairs: #{pairs.inspect}")

    render :json => pairs, :content_type => 'application/json'
  end

end
