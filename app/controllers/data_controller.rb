class DataController < ApplicationController
  before_action :set_datum, only: [:show, :edit, :update, :destroy]

  # GET /data
  # GET /data.json
  def index
    @data = Datum.all
  end

  # GET /data/1
  # GET /data/1.json
  def show
  end

  # GET /data/new
  def new
    @datum = Datum.new
  end

  # GET /data/1/edit
  def edit
  end

  # POST /data
  # POST /data.json
  def create
    @datum = Datum.new(datum_params)

    respond_to do |format|
      if @datum.save
        format.html { redirect_to @datum, notice: 'Datum was successfully created.' }
        format.json { render :show, status: :created, location: @datum }
      else
        format.html { render :new }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data/1
  # PATCH/PUT /data/1.json
  def update
    respond_to do |format|
      if @datum.update(datum_params)
        format.html { redirect_to @datum, notice: 'Datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @datum }
      else
        format.html { render :edit }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data/1
  # DELETE /data/1.json
  def destroy
    @datum.destroy
    respond_to do |format|
      format.html { redirect_to @datum.sensor, notice: 'Datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def updateData
    organization_id = params[:organization_id]
    sensor_id = params[:sensor_id]
    value = params[:value]
    unit = params[:unit]
    date = params[:datetime].to_datetime
    #byebug
    organization = Organization.where(org_id:organization_id)
    if organization.count>0
      sensor = organization[0].sensors.where(sens_id: sensor_id)
      if sensor.count>0
        d = Datum.new(organiz_id: organization_id, sens_id: sensor_id, value: value, unit: unit)
        d.organization = organization[0]
        d.sensor = sensor[0]
        d.date_upload = date
        if d.save
          respond_to do |format|
              format.html {redirect_to sensor[0]}
              format.json {render json: {'Update Succeeded': 'true'}}
          end
        else
          respond_to do |format|
              format.html {render html: 'Update Failed'}
              format.json {render json: {'Update Succeeded': 'false'}}
          end
        end
      else
        respond_to do |format|
            format.html {render html: 'No such sensor exists for the given organization'}
            format.json {render json: {'Sensor Exists': 'False', 'Update Succeeded': 'False'}}
        end
      end
      else
        respond_to do |format|
            format.html {render html: 'No such Organization Exists'}
            format.json {render json: {'Organization Exists': 'False', 'Update Succeeded': 'False'}}
        end
      end
  end

  def sort_data_date
    #byebug
    @sensor = Sensor.find(params[:sens_id])
    @start_date = params[:data][:start_time]
    @end_date = params[:data][:end_time]
    @data = @sensor.data.where('date_upload > ? AND date_upload < ?', @start_date, @end_date )
    params.permit!
    respond_to do |format|
      format.html
      format.csv { send_data @data.to_csv }
      format.xls { send_data @data.to_csv(col_sep: "\t") }
      format.pdf do
         pdf = Prawn::Document.new(top_margin: 70)
         pdf.text "Sensor ID: #{@sensor.sens_id}", size: 30, style: :bold
         pdf.move_down 10
         pdf.text "Organization: #{@sensor.organization.name}", size: 30, style: :bold
         pdf.move_down 10
         pdf.text "Organization: #{@sensor.organization.org_id}", size: 30, style: :bold
         pdf.move_down 10
         pdf.text "Organization: #{@sensor.sens_name}", size: 30, style: :bold

         send_data(pdf.render, options={filename: Organization.find(@sensor.organization_id).org_id + " " + @sensor.sens_id + '.pdf', type: 'application/pdf'})
      end
    end
  end

  def line_items
    pdf.move_down 20
    pdf.table generate_pdf_table
  end

  def generate_pdf_table
    [['Organization ID',	'Sensor ID',	'Value',	'Unit',	'Date of Upload']] +
    @data.line_items.map do |item|
      [item.organiz_id, item.sens_id, item.value, item.unit, item.date_upload]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datum
      @datum = Datum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datum_params
      params.require(:datum).permit(:organization_id, :sensor_id, :organiz_id, :sens_id, :value, :unit, :start_time, :end_time)
    end
end
