class LinksController < ApplicationController
  def show
    @link = Link.find(params[:id])
    # @comments = @link.comments
  end

  def new
    @sub = Sub.find(params[:sub_id])
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render "new"
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render "edit"
    end
  end

  private
  def link_params
    params.require(:link).permit(:title, :url, :body, sub_ids: [])
  end
end
