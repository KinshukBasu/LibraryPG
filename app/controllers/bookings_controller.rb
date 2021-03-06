class BookingsController < AccessController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]


  # GET /bookings
  # GET /bookings.json
  def index
    @booking=Booking.new
    pass_params=params
    if pass_params.key?("date")
      pass_params[:time]=params[:time][:hour]
      pass_params[:date]=Date.new(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i)
      @return_params= Booking.find_availiblty(pass_params)
      render :new, data: pass_params
      return @return_params
    end
    @bookings=Booking.all

  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    # @booking.destroy
    @booking.booking_status='cancelled'
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def search

  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:userid, :room_no, :intime)
  end
end
