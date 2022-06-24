class SessionsController <ApplicationController
	  def signup
    user = User.new(email: params[:email], password: params[:password],name: params[:name],image: params[:image])

    # if user is saved
    if user.save
      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id })

      # return to user
      render json: { token: token }
    else
      # return validation errors
      render json: { message: user.errors },status: 417
    end
  end

  def login
    user = User.find_by(email: params[:email])

    # you can use bcrypt to password authentication
    if user && user.password == params[:password]

      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id })

      # return to user
      render json: { token: token }
    else
      render json: { message: "Incorrect email or password" }
    end
  end
end 