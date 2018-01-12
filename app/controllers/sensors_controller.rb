class SensorsController < ApplicationController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /sensors
  # GET /sensors.json
  def index
    @sensors = Sensor.all
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    sensor = Sensor.find(params[:id])
    if ! sensor.organization.users.include? current_user
      render html: 'Permission Denied'
    end
    params.permit!
    respond_to do |format|
      format.html
      format.csv { send_data sensor.data.to_csv }
      format.xls { send_data sensor.data.to_csv(col_sep: "\t") }
      format.pdf do
         pdf = Prawn::Document.new(top_margin: 70)
         pdf.text "Sensor ID: #{sensor.sens_id}", size: 30, style: :bold
         pdf.move_down 10
         pdf.text "Organization: #{sensor.organization.name}", size: 30, style: :bold
         pdf. move_down 10
         pdf.text "Organization: #{sensor.organization.org_id}", size: 30, style: :bold
         pdf.move_down 10
         pdf.text "Organization: #{sensor.sens_name}", size: 30, style: :bold

         send_data(pdf.render, options={filename: Organization.find(sensor.organization_id).org_id + " " + sensor.sens_id + '.pdf', type: 'application/pdf'})
      end
    end
  end

  def line_items
    pdf.move_down 20
    pdf.table generate_pdf_table
  end

  def generate_pdf_table
    [['Organization ID',	'Sensor ID',	'Value',	'Unit',	'Date of Upload']] +
    sensor.data.line_items.map do |item|
      [item.organiz_id, item.sens_id, item.value, item.unit, item.date_upload]
    end
  end

  # GET /sensors/new
  def new
    @sensor = Sensor.new
  end

  # GET /sensors/1/edit
  def edit
  end

  # POST /sensors
  # POST /sensors.json
  def create
    @sensor = Sensor.new(sensor_params)

    respond_to do |format|
      if @sensor.save
        format.html { redirect_to @sensor, notice: 'Sensor was successfully created.' }
        format.json { render :show, status: :created, location: @sensor }
      else
        format.html { render :new }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to @sensor, notice: 'Sensor was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensor }
      else
        format.html { render :edit }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @sensor.destroy
    respond_to do |format|
      format.html { redirect_to sensors_url, notice: 'Sensor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor).permit(:sens_id, :organization_id, :sens_name)
    end
end
