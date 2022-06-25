class SessionsController <ApplicationController
 def signup
      #taking params user entered to create user
      user = User.new(email: params[:email], password: params[:password],name: params[:name],image: params[:image])
    # if user is saved
    if user.save
      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id })
      # return to user
      render json: { token: token }
    else
      # return validation errors for input they entered
      render json: { message: user.errors },status: 400
    end
  end

  def login
    #find user by email 
    user = User.find_by(email: params[:email])
    # you can use bcrypt to password authentication
    if user && user.password == params[:password]
      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id })
      # return to user
      render json: { token: token }
    else
      render json: { message: "Incorrect email or password" },status: 401
    end
  end
end 