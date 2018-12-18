module FlightsHelper
  def search_on?
    params[:origin] && params[:destination] && params[:date] && params[:passenger_count]
  end
end
