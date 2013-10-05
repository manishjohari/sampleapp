class MoviesController < ApplicationController
	
	before_filter :require_user
	before_filter :get_movie, :only => [:edit, :update, :destroy]

	def index
		if params[:movie]
	      @movie = Movie.new(params[:movie])
     
	      and_conditions = []
	      condition_values = {}
	      unless @movie.id.nil?
	        and_conditions.push "movies.id like :id"
	        condition_values[:id] = "#{@movie.id}"
	      end
	      unless @movie.name.nil?
	        and_conditions.push "movies.name like :name"
	        condition_values[:name] = "%" + "#{@movie.name}" + "%"
	      end
	      unless @movie.actor_id.nil?
	      	and_conditions.push "movies.actor_id like :actor_id"
	      	condition_values[:actor_id] = "#{@movie.actor_id}"
	      end
	      unless @movie.language.nil?
	      	and_conditions.push "movies.language like :language"
	      	condition_values[:language] = "%" + "#{@movie.language}" + "%"
	      end
	      unless @movie.release_date.nil?
	      	and_conditions.push "movies.release_date like :release_date"
	      	condition_values[:release_date] = "#{@movie.release_date}"
	      end
	      
	      if and_conditions.size > 0
	        conditions = [and_conditions.join(" AND "), condition_values]
	      end
	      
	    end
	    

	    @params = params
	    
	    order = []
	    joins = ""
	    if params[:sort]
	    
	      if params[:sort] == params[:last_sort]
	        direction = "DESC"
	        @last_sort = ""
	      else
	        direction = "ASC"
	        @last_sort = params[:sort]
	      end
	      
	      case params[:sort]
	      	when "id"
	          order.push "movies.id #{direction}"
					when "name"
	          order.push "movies.name #{direction}"
	        when "language"
	          order.push "movies.language #{direction}"
	        when "release_date"
	        	order.push "movies.release_date #{direction}"
	        when "created_at"
	          order.push "movies.created_at #{direction}"
	        when "actor_id"
	        	order.push "movies.actor_id #{direction}"
	      end
	    end
	    
	    order.push "movies.id DESC"
	    
	    order_string = order.join(", ") 

		#@movies = Movie.page(params[:page]).order('created_at DESC')
		@movies = Movie.paginate(:order => order_string, :page => params[:page], :conditions => conditions)
	end

	def new
		@movie = current_user.movies.build
	end

	def create
		@movie = current_user.movies.build(params[:movie])
		begin
			Movie.transaction do
				@movie.save!
			end
			flash[:success] = "Movie created successfully"
			redirect_to movies_path
		rescue => e
      	flash.now[:error] = "Something went wrong: #{e}" 
      	render :action => "new"
    end
	end

	def edit
	end

	def update
		@movie.update_attributes(params[:movie])
		begin
			Movie.transaction do 
				@movie.save!
			end
			flash[:success] = "Movie updated successfully"
			redirect_to movies_path
		rescue => e
			flash.now[:error] = "Something went wrong: #{e}" 
			render :action => "edit"
		end
	end

	def destroy
		@movie.destroy
		redirect_to movies_path
	end

	def get_movie
		@movie = Movie.find_by_id(params[:id])
	end

end
