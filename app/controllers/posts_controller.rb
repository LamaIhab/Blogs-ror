class PostsController <ApplicationController

	before_action :authentication

 # GET /posts, returns all posts with their comments
 def index
 	posts = Post.eager_load(:comments)
 	render json: {data: posts},status:200
 end

 def create
		# get user_id from token
		decode_data = decode_user_data(request.headers["token"])
		user_id= decode_data[0]['user_data']
		#validate for tags contains at least one tag and is an array
		tags = params[:tags]
		if !tags.kind_of?(Array)
			render json: {message: "Tags must be an array"},status: 400
			return
		end
		if tags.empty?
			render json: {message: "Tags must contain at least one item"},status: 400
			return
		end
		#create post using params that user entered
		post = Post.new(title: params[:title], body: params[:body],tags: params[:tags],user_id: user_id)
		if post.save
			render json: {message:"Post Created Sucessfully",data: post},status: 201
			return
		else 
			render json: {errors: post.errors},status: 500
			return
		end
	end


  # PATCH/PUT /posts/1, update post for this user
  def update
  	begin
   #checks that this post exists
   post_id = params[:id]
   post = Post.find(post_id)
  	#get user_id and check that this post belongs to them before editing
  	decode_data = decode_user_data(request.headers["token"])
  	user_id= decode_data[0]['user_data']
  	post = Post.where(user_id: user_id, id: post_id)
  	if post.empty?
  		render json: {message: "This operation is not allowed"},status: 405
  		return
  	end
	#update post
	post = post[0]
	#validating on title
	if params[:title]
		if (params[:title]).length < 2
			render json: {message:"Title must contain at least 2 characters"},status: 400
			return
		end
	end
	#validatig on body 
	if params[:body]
		if params[:body].length < 2
			render json: {message:"Body must contain at least 2 characters"},status: 400
			return
		end
	end
	title = params[:title] ? params[:title] : post.title
	body = params[:body] ? params[:body] : post.body
	#validate for tags contains at least one tag and is an array
	tags = params[:tags]
	if tags
		if !tags.kind_of?(Array)
			render json: {message: "Tags must be an array"},status: 400
			return
		end
		if tags.empty?
			render json: {message: "Tags must contain at least one item"},status: 400
			return
		end
	else tags = post.tags
	end
	post = post.update(title: title,body: body,tags: tags)
	if post
		render json: {message:"Post Updated Sucessfully"},status: 200
		return
	else render json: {errors: post},status: 500
	end
rescue => e 
	render json: {message:e},status: 404
end
end



    # DELETE /posts/1 , deleting post of this user along with its comments using relation between them defined in model
    def destroy
    	begin
  		#getting user id from token
  		post_id = params[:id]
  		decode_data = decode_user_data(request.headers["token"])
  		user_id= decode_data[0]['user_data']
	    #checking to see if this post exists for this user
	    post = Post.find(post_id)
	    post = Post.where(user_id: user_id, id: post_id)
	    if post.empty?
	    	render json: {message: "This operation is not allowed"},status: 405
	    	return
	    end
	    post = post[0]
  		#deleting post with its comments
  		post = post.destroy
  		if post
  			render json: {message:"Post Deleted Sucessfully"},status: 200
  			return
  		else render json: {message: "something went wrong"},status: 500
  		end
  	rescue => e
  		render json: {message:e},status: 404
  	end
  end

end


