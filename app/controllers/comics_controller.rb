class ComicsController < ApplicationController

  def cover_art(input)
    return "v1/public/comics/#{input}?"
  end

  def images(path)
    return "#{path}/detail.jpg"
  end
  
  
  
  
  
  def url_handler(method_input) 
    endpoint = "https://gateway.marvel.com/"
    ts = Time.now.to_i
    apikey = "#{Rails.application.credentials.marvel_public_api_key}"
    private_api = "#{Rails.application.credentials.marvel_private_api_key}"
    hash_in = "#{ts}#{Rails.application.credentials.marvel_private_api_key}#{Rails.application.credentials.marvel_public_api_key}"
    md5 = Digest::MD5.new
    md5 << hash_in
    hash = md5.hexdigest
    api_string = "ts=#{ts}&apikey=#{apikey}&hash=#{hash}"

    return HTTP.get("#{endpoint}#{method_input}#{api_string}")
  end

  def cover_art_by_issue_id
    input = params["comic_id"]
    cover_art_path = cover_art(input)
    response = url_handler(cover_art_path)
    endpoint = JSON.parse(response.body)["data"]["results"][0]["thumbnail"]["path"]
    photo = images(endpoint)
    render json: photo
  end

end
