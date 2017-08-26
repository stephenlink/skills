class PostsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_post, only: [:destroy]

	def index 
		@posts = Post.all
	end

	def new 
		@post= current_user.posts.build
	end


	def create
		@post = current_user.posts.build(post_params)

        if @post.save
          flash[:success] = "Your post has been created!"
          redirect_to posts_path
        else
          flash[:alert] = "Your new post couldn't be created!  Please check the form."
          render :new
        end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:skill)
	end
end
