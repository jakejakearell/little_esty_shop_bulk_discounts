require 'faraday'
require 'json'

class NagerService
  def holiday_info
    endpoint = "https://date.nager.at/Api/v2/NextPublicHolidays/US"
    get_data(endpoint)
  end

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    parsed = JSON.parse(response.body, symbolize_names: true)
    next_three_holidays = parsed[0..2]
  end
end
