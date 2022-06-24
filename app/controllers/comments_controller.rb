class CommentsController <ApplicationController


	before_action :authentication


	def create
		# get user_id from token
		begin
			#DeletePosts.perform_async
		decode_data = decode_user_data(request.headers["token"])
		user_id= decode_data[0]['user_data']
		#create comment
		post = Post.find(params[:post_id])
		comment = Comment.new(description: params[:description], post_id: params[:post_id],user_id: user_id)
		if comment.save
			render json: {message:"Comment Created Sucessfully",data: comment},status: 201
			return
		else 
			render json: {errors: comment.errors},status: 417
			return
		end
	rescue => e
		render json: {message:e},status: 404
	end
	end


  # PATCH/PUT /comments/1
  def update
  	begin
   #checks that this comment exists
  	comment_id = params[:id]
  	comment = Comment.find(comment_id)
  	#get user_id and check that this comment belongs to them before editing
  	decode_data = decode_user_data(request.headers["token"])
	user_id= decode_data[0]['user_data']
	comment = Comment.where(user_id: user_id, id: comment_id)
	if comment.empty?
		render json: {message: "This operation is not allowed"},status: 405
		return
	end
	#update post
	comment = comment[0]
	description = params[:description]
	if params[:description]
		if (params[:description]).length < 2
			render json: {message:"Description must contain at least 2 characters"},status: 417
			return
		end
	else description = comment.description
	end
	comment = comment.update(description: description)
   if comment
		render json: {message:"Comment Updated Sucessfully"},status: 200
			return
		else render json: {errors: comment},status: 500
		end
  rescue => e 
  	render json: {message:e},status: 404
   end
  end



    # DELETE /comments/1 
  def destroy
  	begin
  		comment_id = params[:id]
  		decode_data = decode_user_data(request.headers["token"])
	    user_id= decode_data[0]['user_data']
  		comment = Comment.find(comment_id)
  		comment = Comment.where(user_id: user_id, id: comment_id)
  		if comment.empty?
  			render json: {message: "This operation is not allowed"},status: 405
		return
  		end
  		comment = comment[0]
  		comment = comment.destroy
  		if comment
  		render json: {message:"Comment Deleted Sucessfully"},status: 200
			return
		else render json: {message: "something went wrong"},status: 500
		end
  	rescue => e
  		render json: {message:e},status: 404
  	end
  end

end


