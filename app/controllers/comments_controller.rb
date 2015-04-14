class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
=begin
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.create(params[:comment].permit(:comment))
    @comment.user = current_user
    @comment.save

    if @comment.save
      redirect_to movie_path(@movie)
      
    else
      render 'new'
    end
=end
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.movie_id = @movie.id
    @comment.save

    respond_to do |format|
      if @comment.save
        format.html { redirect_to movie_path(@movie), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
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

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
