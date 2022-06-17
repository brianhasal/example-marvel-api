class CharactersController < ApplicationController


  def character(input)
    return "v1/public/characters?name=#{input}&"
  end

  def character_id(input)
    return "/v1/public/characters/#{input}?"
  end

  def images(path)
    return "#{path}/detail.jpg"
  end

  def character_list_starts_with(input)
    return "v1/public/characters?nameStartsWith=#{input}&limit=100&"

  end

  def endpoint_for_character_list
    return "v1/public/characters?limit=100&"
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



  def index
    input = params["name"]
    character = character(input)
    response = url_handler(character)
    marvel_data = JSON.parse(response.body)
    render json: marvel_data
  end

  def character_by_id
    input = params["character_id"]
    character_id_path = character_id(input)
    response = url_handler(character_id_path)
    character = JSON.parse(response.body)
    render json: character
  end

  def photos_by_id
    input = params["character_id"]
    character_id_path = character_id(input)
    response = url_handler(character_id_path)
    endpoint = JSON.parse(response.body)["data"]["results"][0]["thumbnail"]["path"]
    photo = images(endpoint)
    render json: photo
  end

  
  def photos
    input = params["name"]
    character = character(input)
    response = url_handler(character)
    endpoint = JSON.parse(response.body)["data"]["results"][0]["thumbnail"]["path"]
    photo = images(endpoint)
    render json: photo
  end

  def character_starts_with
    user_input = params["letters"]
    input = character_list_starts_with(user_input)
    response = url_handler(input)
    character_list = JSON.parse(response.body)["data"]["results"]
    character_list.each do |character|
      puts character["name"]
      puts "---------------------------"
    end
    render json: character_list
  end

  def character_list
    response = url_handler(endpoint_for_character_list)
    character_list = JSON.parse(response.body)["data"]["results"]
    character_list.each do |character|
      puts character["name"]
      puts "---------------------------"
    end
    render json: character_list
  end









end
