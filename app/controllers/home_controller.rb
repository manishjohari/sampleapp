class HomeController < ApplicationController

def index
@movies = Movie.page(params[:page]).find(:all, :limit => 5, :order=> 'created_at desc')
end

end
