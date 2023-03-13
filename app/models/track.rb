class Track
  def initialize(params)
    puts "Initialize with"
    p params
    @params = params.permit!.to_hash.deep_symbolize_keys
  end

  def id
    @params[:track_id]
  end


  def artist
    @params[:track_artist]
  end

  def album
    @params[:track_album]
  end

  def name
    @params[:track_name]
  end

  def image
    @params[:track_image]
  end
end
