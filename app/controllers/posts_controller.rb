class PostsController < ApplicationController
	# This says that signed in users are the only ones
	# that can go to the new, create, and destroy pages
	# however all users can see the index. This will be
	# the root page when finished.
	# Could also do :signed_in_user, except: [:index]
	before_filter :signed_in_user, only: [:new, :create, :destroy]
	# This correct_user method is different than the one
	# defined in the users controller because this one
	# tests to make sure that the user_id for that post
	# correlates to the correct user.
	before_filter :correct_user,   only: :destroy

	def index
		# Index paginates posts so 7 per page
		@posts = Post.page(params[:page]).per_page(7)
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.new(params[:post])
		if @post.save
			flash[:success] = "Post submitted!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def destroy
		if (@post.user_id == current_user.id) || current_user.admin?
			@post.destroy
			flash[:success] = "Post destroyed."
			redirect_to root_url
		else
			flash[:error] = "Not possible."
			redirect_to	root_url
		end
	end

	private

		def correct_user
			@post = Post.find_by_id(params[:id])
			redirect_to root_url if @post.nil?
		end
end