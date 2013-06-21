class PostsController < ApplicationController
	# This says that signed in users are the only ones
	# that can go to the new, create, and destroy pages
	# however all users can see the index. This will be
	# the root page when finished.
	# Could also do :signed_in_user, except: [:index]
	before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
	# This correct_user method is different than the one
	# defined in the users controller because this one
	# tests to make sure that the user_id for that post
	# correlates to the correct user.
	before_filter :correct_user,   only: [:edit, :update, :destroy]
	before_filter :story_owner,    only: [:edit, :update]

	def index
		# Index paginates posts so 7 per page
		@posts = Post.page(params[:page]).per_page(7)
	end

	def popular
		@posts = Post.page(params[:page]).per_page(7).find_with_reputation(:votes, :all, order: "votes desc")
	end

	def lame
		@posts = Post.page(params[:page]).per_page(7).find_with_reputation(:votes, :all, order: "votes asc")
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

	def edit
		@post = Post.find(params[:id])
	end

	def update
		if @post.update_attributes(params[:post])
      # Handle a successful update
      flash[:success] = "Story updated"
      redirect_to root_url
    else
       # Re-render the page but this time the error
       # messages will show (coded into edit view)
       render 'edit'
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

	def vote
		if signed_in?
			value = params[:type] == "up" ? 1 : -1
			@post = Post.find(params[:id])
			@post.add_or_update_evaluation(:votes, value, current_user)
			redirect_to :back, notice: "Your vote actually counted for something!"
		else
			redirect_to :back, notice: "You must be signed in to vote."
		end
	end

	private

		def correct_user
			@post = Post.find_by_id(params[:id])
			redirect_to root_url if @post.nil?
		end

		def story_owner
			@post = Post.find(params[:id])
			redirect_to root_url unless (@post.user_id == current_user.id) || current_user.try(:admin?)
		end
end