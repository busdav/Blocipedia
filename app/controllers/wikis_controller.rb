class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki).all
    authorize @wikis
  end

  def show
    @wiki = policy_scope(Wiki).find(params[:id])
    authorize @wiki
    @collaborators = @wiki.collaborators
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user_id = current_user.id
    @wiki.private = params[:wiki][:private]
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = policy_scope(Wiki).find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = policy_scope(Wiki).find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = policy_scope(Wiki).find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "The wiki \"#{@wiki.title}\" has been successfully deleted"
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki \"#{@wiki.title}\""
      render :show
    end
  end
end
