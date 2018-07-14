class SchedulesController < ApplicationController
  before_action :authenticate_business!, only: [:business_show]
  before_action :authenticate_customer!, only: [:customer_show, :new, :create]

  def customer_show
    @schedules = Schedule.where(customer_id: current_customer.id, deletado: 0)
  end

  def business_show
    @schedules = Schedule.where(business_id: current_business.id, deletado: 0)
  end

  def new
    @business = Business.find(params[:business_id])
    @schedule = Schedule.new
    @schedule.business = @business
    @schedule.customer = current_customer
  end

  # XHG
  def create
    Schedule.transaction do
      @schedule = Schedule.new(schedule_params)
      if not params[:service_ids]
        respond_to do |format|
          format.html { redirect_to new_business_schedule_path(@schedule.business_id), notice: 'Schedule was not successfully created.' }
        end
      else
        @schedule.deletado = 0
        @schedule.save
        for service_id in params[:service_ids]
          @schedule_service = ScheduleService.new
          @schedule_service.service_id = service_id
          @schedule_service.schedule_id = @schedule.id
          @schedule_service.save
        end
        respond_to do |format|
          format.html { redirect_to schedules_customer_show_path, notice: 'Schedule was successfully created.' }
        end
      end
    end
  end


  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.deletado = 1
    @schedule.cancelado = Time.now.getutc
    @schedule.save

    redirect_to schedules_customer_show_path
  end

  private
    def schedule_params
      params.require(:schedule).permit(:hour, :date, :evaluation, :customer_id, :business_id, :car_id)
    end
end
