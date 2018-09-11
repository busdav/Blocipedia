class CollaboratorsController < ApplicationController
  # before_action :set_collaborator, only: [:show, :edit, :update, :destroy]

  # # GET /collaborators
  # # GET /collaborators.json
  # def index
  #   @collaborators = Collaborator.all
  # end
  #
  # # GET /collaborators/1
  # # GET /collaborators/1.json
  # def show
  # end
  #
  # # GET /collaborators/new
  # def new
  #   @collaborator = Collaborator.new
  # end
  #
  # # GET /collaborators/1/edit
  # def edit
  # end

  # POST /collaborators
  # POST /collaborators.json
  # def create
  #   @collaborator = Collaborator.new(collaborator_params)
  #
  #   respond_to do |format|
  #     if @collaborator.save
  #       format.html { redirect_to @collaborator, notice: 'Collaborator was successfully created.' }
  #       format.json { render :show, status: :created, location: @collaborator }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @collaborator.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    current_collaborators = @wiki.users
    # @user = User.find_by(email: params[:collaborator][:user])
    @user = User.where('email LIKE ?', "%#{params[:search]}%").first
          # .all_except(current_user)
          # .exclude_collaborators(@wiki)
          # .first
    if @user
      if current_collaborators.include?(@user) || @user == current_user
        flash[:alert] = "User is already a collaborator."
        redirect_to @wiki
      else
        @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)

        if @collaborator.save
          flash[:notice] = "Collaborator has been added!"
        else
          flash[:error] = "Error adding collaborator, please try again."
        end
        redirect_to @wiki
      end
    else
      flash[:alert] = "Sorry, no such user exists. "
      redirect_to @wiki
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator has been successfully removed. "
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error removing this collaborator."
      redirect_to @wiki
    end
  end
end

  # def create
  #   @wiki = Wiki.find(params[:wiki_id])
  #   @user = User.where('username LIKE ?', "%#{params[:search]}%")
  #             # .except(current_user)
  #             # .exclude_collaborators(@wiki)
  #             # .first
  #   if @user
  #     @collaborator = Collaborator.new
  #     @collaborator.wiki_id = @wiki
  #     @collaborator.user_id = @user
  #     if @collaborator.save
  #       flash[:notice] = "Collaborator successfully added to wiki."
  #     else
  #       flash.now[:alert] = "There was a problem adding the collaborator. Please try again."
  #     end
  #   else
  #     flash.now[:alert] = "Sorry that wasn't a valid username. Please try again."
  #   end
  #   redirect_to @wiki
  # end

  # # PATCH/PUT /collaborators/1
  # # PATCH/PUT /collaborators/1.json
  # def update
  #   respond_to do |format|
  #     if @collaborator.update(collaborator_params)
  #       format.html { redirect_to @collaborator, notice: 'Collaborator was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @collaborator }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @collaborator.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /collaborators/1
  # DELETE /collaborators/1.json
  # def destroy
  #   @collaborator.destroy
  #   respond_to do |format|
  #     format.html { redirect_to collaborators_url, notice: 'Collaborator was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_collaborator
  #     @collaborator = Collaborator.find(params[:id])
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def collaborator_params
  #     params.fetch(:collaborator, {})
  #   end

  # def destroy
  #   @collaborator = Collaborator.find(params[:id])
  #
  #   if @collaborator.destroy
  #     flash[:notice] = "The collaborator has successfully been deleted"
  #     redirect_to wikis_path
  #   else
  #     flash.now[:alert] = "There was an error deleting the collaborator"
  #     redirect_to wikis_path
  #   end
  # end
# end
