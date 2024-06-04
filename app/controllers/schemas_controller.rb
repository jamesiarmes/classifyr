# frozen_string_literal: true

# Controller for schema routes.
class SchemasController < ApplicationController
  before_action :set_schema, only: %i[show edit update destroy]
  before_action :set_breadcrumbs

  def index
    authorize! :index, :schemas
    @schemas = Schema.ordered
  end

  def show
    authorize! :show, :schemas
    add_breadcrumb(@schema.title, schema_path(@schema))
  end

  def new
    authorize! :new, :schemas
    @schema = Schema.new
    add_breadcrumb(t('.title'), nil)
  end

  def edit
    authorize! :edit, :schemas
    add_breadcrumb(t('.breadcrumb', title: @schema.title), edit_schema_path(@schema))
  end

  def create
    authorize! :create, :schemas
    @schema = Schema.new(schema_params)

    if @schema.save
      redirect_to schema_path(@schema), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, :schemas
    @schema = Schema.new(schema_params)

    if @schema.save
      redirect_to schema_path(@schema), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :update, :schemas
    @schema.destroy

    redirect_to schemas_url, notice: t('.success')
  end

  private

  def schema_params
    params.require(:schema).permit(:title)
  end

  def set_schema
    @schema = find_by_slug_with_history(Schema, params[:slug])
  end

  def set_breadcrumbs
    add_breadcrumb(t('.title'), schemas_path)
  end
end
