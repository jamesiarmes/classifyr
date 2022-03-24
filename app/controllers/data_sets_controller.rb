class DataSetsController < ApplicationController
  before_action :set_data_set, only: %i[ show edit update destroy map analyze ]

  def index
    @data_sets = DataSet.all
  end

  def show
  end

  def new
    @data_set = DataSet.new
  end

  def edit
  end

  def create
    @data_set = DataSet.new(data_set_params)

    if @data_set.save
      redirect_to map_data_set_path(@data_set), notice: "DataSet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @data_set.update(data_set_params)
      redirect_to data_set_url(@data_set), notice: "Data set was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @data_set.destroy

    redirect_to data_sets_url, notice: "Data set was successfully destroyed."
  end

  def map
    @data_set.prepare_datamap
  end

  def analyze
    @data_set.analyze_files!

    redirect_to data_sets_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_set
      @data_set = DataSet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def data_set_params
      params.require(:data_set).permit(:name, :city, :state, files: [])
    end
end
