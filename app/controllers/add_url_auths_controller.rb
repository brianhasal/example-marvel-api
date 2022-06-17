class AddUrlAuthsController < ApplicationController


  def marvel_url(input)
    return "#{input}?"
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
    input = params["raw_marvel_url"]
    response = url_handler(input)
    # FIX THIS PART BELOW!!! #
    # endpoint = JSON.parse(response.body)["data"]["results"][0]["thumbnail"]["path"]
    # photo = images(endpoint)
    # render json: photo
  end
  

  
end
