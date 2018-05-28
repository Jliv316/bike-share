class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def show; end

  def index
    @trips = Trip.paginate(page: params[:page], per_page: 30)
  end

  def dashboard
    @average_trip_duration = Trip.average_trip_duration
    @longest_ride          = Trip.longest_duration
    @shortest_ride         = Trip.shortest_duration

    most_ridden_bike_stats  = Trip.most_ridden_bike
    @most_ridden_bike       = most_ridden_bike_stats[0]
    @most_ridden_bike_count = most_ridden_bike_stats[1]

    least_ridden_bike_stats  = Trip.least_ridden_bike
    @least_ridden_bike       = least_ridden_bike_stats[0]
    @least_ridden_bike_count = least_ridden_bike_stats[1]

    most_popular_date_stats  = Trip.most_popular_date
    @most_popular_date       = most_popular_date_stats[0]
    @most_popular_date_count = most_popular_date_stats[1]

    least_popular_date_stats  = Trip.least_popular_date
    @least_popular_date       = least_popular_date_stats[0]
    @least_popular_date_count = least_popular_date_stats[1]

    @subscription_types_breakdown = Trip.subscription_type_breakdown
  end

  private

    def set_trip
      @trip = Trip.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:duration, :start_date, :end_date,
                                   :start_station, :end_station, :bike_id,
                                   :subscription_type, :zip_code)
    end
end
