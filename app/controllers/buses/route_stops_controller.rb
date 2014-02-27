class Buses::RouteStopsController < ApplicationController
  
  def create
    @route_stop = RouteStop.new(route_stop_params)

    rs = RouteStop.where(route_id: @route_stop.route.id).order(:index).first()
    idx = 0
    print idx
    if rs
      idx = rs.index
    end
    
    print idx
    
    @route_stop.index = idx + 1

    if @route_stop.save
      flash[:success] = "Success"
      redirect_to buses_timetable_route_route_stops_path(@route_stop.route)
    else
      flash[:error] = "Fail"
      print @route_stop.errors.full_messages
      redirect_to "/"
    end
  end
  
  private
  
  def route_stop_params
    params.require(:route_stop).permit(:stop_id, :route_id)
  end
  
  def route_params
    params.permit(:route_id)
  end
  
end