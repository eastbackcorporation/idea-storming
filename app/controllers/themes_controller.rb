# frozen_string_literal: true

class ThemesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_theme, only: %i[show edit update]
  before_action :check_owner, only: %i[edit update]

  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
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
    @theme.category = Category.find_by(id: params[:theme][:category])
    @theme.owner = current_user

    respond_to do |format|
      if @theme.save
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
      @theme.category = Category.find_by(id: params[:theme][:category])
      if @theme.save
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def theme_params
    params.require(:theme).permit(:title, :description)
  end

  # Check current user is thema owner.
  def check_owner
    redirect_to :root unless @theme.owner?(current_user)
  end
end
