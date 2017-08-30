class PostsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_post, only: [:like, :destroy]

	def index 
		@posts = Post.all.order('created_at DESC')
	end

	def new 
		@post= current_user.posts.build
	end


	def create
		@post = current_user.posts.build(post_params)

        if @post.save
          flash[:success] = "Your post has been created!"
          redirect_to profile_path(current_user.user_name)
        else
          flash[:alert] = "New post couldn't be created"
          render :new
        end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def like
	  if @post.user == current_user
	  #cant reccomend your own post!
	  else 
	    if @post.liked_by current_user
          respond_to do |format|
            format.html { redirect_to :back }
            format.js
          end
        end
      end
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:skill)
	end
end
