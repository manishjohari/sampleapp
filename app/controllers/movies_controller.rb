class MoviesController < ApplicationController
	
	before_filter :require_user
	before_filter :get_movie, :only => [:edit, :update, :destroy]

	def index
		@movies = Movie.page(params[:page]).order('created_at DESC')
	end

	def new
		@movie = current_user.movies.build
	end

	def create
		@movie = current_user.movies.build(params[:movie])
		Movie.transaction do
			@movie.save!
		end
		flash[:success] = "yoyo"
		redirect_to movies_path
	end

	def edit
	end

	def update
		@movie.update_attributes(params[:movie])
		Movie.transaction do 
			@movie.save!
		end
		flash[:success] = "yoyo updated"
		redirect_to movies_path
	end

	def destroy
		@movie.destroy
		redirect_to movies_path
	end

	def get_movie
		@movie = Movie.find_by_id(params[:id])
	end

end
