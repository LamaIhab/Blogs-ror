class ApplicationController < ActionController::API
 SECRET = "yoursecretword"

# function used as middleware function to be called before any controller operates
def authentication
    # making a request to a secure route, token must be included in the headers
    begin
     decode_data = decode_user_data(request.headers["token"])
     if !decode_data
      render json: { message: "Unauthorized" },status: 401
      return
    end
    # getting user id from a nested JSON in an array.
    user_id= decode_data[0]['user_data']
    # find a user in the database to be sure token is for a real user
    user = User.find(user_id)
    if user
      return true
    else
      render json: { message: "Unauthorized" },status: 401
    end
  rescue => e
    render json: {message: "Unauthorized"},status: 401
  end
end

  # turn user data (payload) to an encrypted string  [ A ]
  def encode_user_data(payload)
    token = JWT.encode payload, SECRET, "HS256"
    return token
  end

  # turn user data (payload) to an encrypted string  [ B ]
  def encode_user_data(payload)
    JWT.encode payload, SECRET, "HS256"
  end

  # decode token and return user info, this returns an array, [payload and algorithms] [ A ]
  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end

  # decode token and return user info, this returns an array, [payload and algorithms] [ B ]
  def decode_user_data(token)
    begin
      JWT.decode token, SECRET, true, { algorithm: "HS256" }
    rescue => e
      puts e
    end
  end
end
