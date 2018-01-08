class PunchLogsController < ApplicationController
  before_action :set_punch_log, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token,
  if: Proc.new { |c| c.request.format == 'application/json' }

  # GET /punch_logs
  # GET /punch_logs.json
  def index
    # @punch_logs = PunchLog.all
    @punch_logs = PunchLog.search(params).order("created_at desc")
    if params.dig :PunchLog, :generate_record
      @records = PunchLogsHelper.generate_record(@punch_logs)
      user_id = params.dig(:User, :user_id); time_span = params.dig(:PunchLog, :time_span)
      link_label = "PunchLogs_#{User.find(user_id).name}"
      link_label << "_#{DateTime.parse(time_span).strftime("%Y-%m")}" if !time_span.to_s.empty?
      respond_to do |format|
        format.csv do
          send_data render_to_string, filename: "#{link_label}.csv", type: :csv
        end
      end
    end
  end

  # GET /punch_logs/1
  # GET /punch_logs/1.json
  def show
  end

  # GET /punch_logs/new
  def new
    @punch_log = PunchLog.new
  end

  # GET /punch_logs/1/edit
  def edit
  end

  # POST /punch_logs
  # POST /punch_logs.json
  def create
    @punch_log = PunchLog.new(punch_log_params)

    respond_to do |format|
      if @punch_log.save
        format.html { redirect_to @punch_log, notice: 'Punch log was successfully created.' }
        format.json { render :show, status: :created, location: @punch_log }
      else
        format.html { render :new }
        format.json { render json: @punch_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /punch_logs/1
  # PATCH/PUT /punch_logs/1.json
  def update
    respond_to do |format|
      if @punch_log.update(punch_log_params)
        format.html { redirect_to @punch_log, notice: 'Punch log was successfully updated.' }
        format.json { render :show, status: :ok, location: @punch_log }
      else
        format.html { render :edit }
        format.json { render json: @punch_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /punch_logs/1
  # DELETE /punch_logs/1.json
  def destroy
    @punch_log.destroy
    respond_to do |format|
      format.html { redirect_to punch_logs_url, notice: 'Punch log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_punch_log
      @punch_log = PunchLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def punch_log_params
      params.require(:punch_log).permit(:card_uid, :card_type, :created_at)
    end
end
