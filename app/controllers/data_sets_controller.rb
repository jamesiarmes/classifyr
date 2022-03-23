class DataSetsController < ApplicationController
  before_action :set_data_set, only: %i[ show edit update destroy ]

  # GET /data_sets or /data_sets.json
  def index
    @data_sets = DataSet.all
  end

  # GET /data_sets/1 or /data_sets/1.json
  def show
  end

  # GET /data_sets/new
  def new
    @data_set = DataSet.new
  end

  # GET /data_sets/1/edit
  def edit
  end

  # POST /data_sets or /data_sets.json
  def create
    @data_set = DataSet.new(data_set_params)

    respond_to do |format|
      if @data_set.save
        format.html { redirect_to data_set_url(@data_set), notice: "DataSet was successfully created." }
        format.json { render :show, status: :created, location: @data_set }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @data_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_sets/1 or /data_sets/1.json
  def update
    respond_to do |format|
      if @data_set.update(data_set_params)
        format.html { redirect_to data_set_url(@data_set), notice: "Data set was successfully updated." }
        format.json { render :show, status: :ok, location: @data_set }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @data_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_sets/1 or /data_sets/1.json
  def destroy
    @data_set.destroy

    respond_to do |format|
      format.html { redirect_to data_sets_url, notice: "Data set was successfully destroyed." }
      format.json { head :no_content }
    end
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
