class ActorsController < ApplicationController

	before_filter :require_user
	before_filter :get_actor, :only=>[:edit, :update, :destroy]
	
	def index
		@actors = Actor.page(params[:page]).order('name ASC')
	end

	def new
		@actor = Actor.new
	end

	def create
		@actor = Actor.new(params[:actor])
		begin
			Actor.transaction do
				@actor.save!
			end
			flash[:success] = "Actor created successfully"
			redirect_to actors_path
		rescue => e
			flash.now[:error] = "Something went wrong: #{e}" 
      render :action => "new"
		end
	end

	def edit
	end

	def update
		@actor.update_attributes(params[:actor])
		begin
			Actor.transaction do 
			@actor.save!
			end
			flash[:success] = "Actor updated successfully"
			redirect_to actors_path	
		rescue => e
			flash.now[:error] = "Something went wrong: #{e}" 
			render :action => 'edit'
		end
		
	end

	def destroy
		@actor.destroy
		redirect_to actors_path
	end

	def get_actor
		@actor = Actor.find_by_id(params[:id])
	end

end
