class StoriesController < ApplicationController

  def stories(input)
    return "v1/public/stories/#{input}?"
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

  def stories_by_stories_id
    input = params["stories_id"]
    stories_path = stories(input)
    response = url_handler(stories_path)
    story = JSON.parse(response.body)
    render json: story
  end

end
