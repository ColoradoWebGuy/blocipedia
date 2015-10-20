class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def index
    @users = User.all
  end

  def create
    @user = User.find(params[:user_id])
    @collaborator = @wiki.collaborators.build(user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "#{@user.email} is now a collaborator!"
    else
      flash[:alert] = "#{@user.email} couldn't be added. Try again."
    end

    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    @user = User.find(params[:user_id])
    #find the collaborator's id, and return it to be destroyed
    @collaborator = Collaborator.where(wiki_id: params[:id], user_id: params[:user_id]).first

    if @collaborator.destroy
      flash[:notice] = "#{@user.email} is no longer a collaborator."
    else
      flash[:alert] = "#{@user.email} couldn't be removed. Try again."
    end

    redirect_to wiki_collaborators_path(@wiki)
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

end
