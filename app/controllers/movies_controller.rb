class MoviesController < ApplicationController
 
    def index
        @movies = Movie.all

        if params[:published] == 'true' && params[:draft] == 'true'
            @movies = Movie.all
        elsif params[:published] == 'true'
            @movies = Movie.published
        elsif params[:draft] == 'true'
            @movies = Movie.draft
        end

        if params[:released] == 'true' && params[:upcoming] == 'true'
            @movies = Movie.all
        elsif params[:released] == 'true'
            @movies = @movies.where('release_year <= ?', Date.today.year)
        elsif params[:upcoming] == 'true'
            @movies = @movies.where('release_year > ?', Date.today.year)
        end
    end

    def show
        @movie = Movie.find(params[:id])
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(title: params[:movie][:title],
                           release_year: params[:movie][:release_year],
                           synopsis: params[:movie][:synopsis],
                           country: params[:movie][:country],
                           duration: params[:movie][:duration],
                           director_id: params[:movie][:director_id],
                           genre_id: params[:movie][:genre_id])
        
        if params[:movie][:poster]
            @movie.poster.attach(params[:movie][:poster])
        end
        
        if @movie.save
            return redirect_to movie_path @movie.id
        end

        render :new
    end

    def edit
        @movie = Movie.find(params[:id])
    end

    def update
        @movie = Movie.find(params[:id])

        if params[:movie][:poster]
            @movie.poster.attach(params[:movie][:poster])
        end

        if @movie.update(title: params[:movie][:title],
                         release_year: params[:movie][:release_year],
                         synopsis: params[:movie][:synopsis],
                         country: params[:movie][:country],
                         duration: params[:movie][:duration],
                         director_id: params[:movie][:director_id],
                         genre_id: params[:movie][:genre_id])
            return redirect_to movie_path @movie.id
        end

        render :edit
    end

    def publish
        movie = Movie.find(params[:id])
        movie.published!
        redirect_to movie_path movie.id
    end
    
end
