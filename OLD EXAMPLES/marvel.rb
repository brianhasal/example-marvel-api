require "http"
require "digest"



def characters(input)
  return "v1/public/characters?name=#{input}&"
end

def comics(input_code)
  return "v1/public/comics/#{input_code}?"
end

def images(path)
  return "#{path}/detail.jpg"
end

# spidey = characters("Spider-Man")
# cap = characters("Captain America")
# hulk = characters("Hulk")
hero = characters("Hawkeye")
avengers12010 = comics(29195)

#Builds and returns query url for "response"
def url_handler(method_input) 
  endpoint = "https://gateway.marvel.com/"
  ts = Time.now.to_i
  apikey = "#{ENV["MARVEL_PUBLIC_API_KEY"]}"
  private_api = "#{ENV["MARVEL_PRIVATE_API_KEY"]}"
  hash_in = "#{ts}#{ENV["MARVEL_PRIVATE_API_KEY"]}#{ENV["MARVEL_PUBLIC_API_KEY"]}"
  md5 = Digest::MD5.new
  md5 << hash_in
  hash = md5.hexdigest
  api_string = "ts=#{ts}&apikey=#{apikey}&hash=#{hash}"

  return HTTP.get("#{endpoint}#{method_input}#{api_string}")
end

# response = url_handler(avengers12010)
response = url_handler(hero)
marvel_data = JSON.parse(response.body)
pp marvel_data


# marvel_data.each do |section|
#   pp section
#   p "#######################"
# end



# pp marvel_data["data"]["results"][0]["comics"]["items"]

# marvel_data["data"]["results"][0]["comics"]["items"].each do |resource|
#   puts resource["resourceURI"]
#   puts resource["name"] 
#   puts ""
# end





#### +++++++++++++++++++++++++++ FROM HERE DOWN IT WORKS



# endpoint = "http(s)://gateway.marvel.com/"
# ts = Time.now.to_i
# apikey = "#{ENV["MARVEL_PUBLIC_API_KEY"]}"
# hash_in = "#{ts}#{ENV["MARVEL_PRIVATE_API_KEY"]}#{ENV["MARVEL_PUBLIC_API_KEY"]}"
# private_api = "#{ENV["MARVEL_PRIVATE_API_KEY"]}"

# md5 = Digest::MD5.new
# md5 << hash_in
# hash = md5.hexdigest



# response = HTTP.get("https://gateway.marvel.com:443/v1/public/characters?name=Hawkeye&ts=#{ts}&apikey=6ac0fcf29b4bdef28b2b1dacbe2b7d71&hash=#{hash}")


# marvel_data = JSON.parse(response.body)
# pp marvel_data

