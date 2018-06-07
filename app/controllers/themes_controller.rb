# frozen_string_literal: true

class ThemesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_theme, only: %i[show edit update]
  before_action :set_theme_tags, only: %i[new create edit update]
  before_action :set_categories, only: %i[new create edit update]
  before_action :check_owner, only: %i[edit update]

  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.search_content(params[:search_content])
    @themes = @themes.include_category(params[:category_id]) if params[:category_id].present?

    @themes =
      case params[:order_by]&.to_sym
      when :ideas_count
        @themes.order_ideas_count
      else
        @themes.order(updated_at: :desc)
      end
    @themes = @themes.page(params[:page])
  end

  # GET /themes/1
  # GET /themes/1.json
  def show; end

  # GET /themes/new
  def new
    @theme = Theme.new
  end

  # GET /themes/1/edit
  def edit; end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(theme_params)
    @theme.category = Category.find_by(id: params[:theme][:category_id])
    @theme.owner = current_user

    respond_to do |format|
      if @theme.save && @theme.save_tags(theme_tags_params)
        format.html { redirect_to themes_path, notice: t('.success') }
        format.json { render :show, status: :created, location: @theme }
      else
        format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    respond_to do |format|
      @theme.assign_attributes(theme_params)
      @theme.category = Category.find_by(id: params[:theme][:category_id])
      if @theme.save && @theme.save_tags(theme_tags_params)
        format.html { redirect_to @theme, notice: t('.success') }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_theme
    @theme = Theme.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def theme_params
    params.require(:theme).permit(:title, :description, images: [], images_attachments_attributes: %i[id _destroy])
  end

  def set_theme_tags
    @theme_tags = params[:theme_tags] || @theme&.tags&.pluck(:name)&.join(',').to_s
  end

  def theme_tags_params
    @theme_tags.split(',')
  end

  # Check current user is thema owner.
  def check_owner
    redirect_to :root unless @theme.owner?(current_user)
  end
end
