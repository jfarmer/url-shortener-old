class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :require_authorization!, only: [:edit, :update, :destroy]

  def index
    @links = Link.order('created_at DESC').includes(:user)
  end

  def show
    if @link
      @link.click!

      redirect_to @link.url
    else
      render text: 'No such link.', status: 404
    end
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user

    if @link.save
      redirect_to root_url, notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to root_url, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @link.destroy
    redirect_to :back, notice: 'Link was successfully destroyed.'
  end

  private

  def set_link
    @link = Link.find_by_short_name(params[:short_name])
  end

  def require_authorization!
    unless @link.editable_by?(current_user)
      head :forbidden
    end
  end

  def link_params
    params.require(:link).permit(:url)
  end
end
