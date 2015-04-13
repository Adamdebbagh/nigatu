class CommentsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.create(params[:comment].permit(:comment))
    @comment.user = current_user
    @comment.save

    if @comment.save
      redirect_to movie_path(@movie)
      
    else
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])

    if @comment.update(params[:comment].permit(:comment))
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])
    @comment.destroy
    redirect_to movie_path(@movie)
  end

end
