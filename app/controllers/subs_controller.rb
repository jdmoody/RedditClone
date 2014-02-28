class SubsController < ApplicationController
  def index
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
    5.times do
      @sub.links.build
    end
  end

  def create
    @sub = current_user.subs.new(name: params[:sub][:name])
    @sub.links.new(links_params)
    current_user.links << @sub.links
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      (5 - @sub.links.length).times { @sub.links.build }
      render "new"
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(name: params[:sub][:name])
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render "edit"
    end
  end

  private
  def links_params
    params.permit(links: [:title, :url, :body])
          .require(:links)
          .values
          .reject { |data| data.values.all?(&:blank?) }
  end
end
