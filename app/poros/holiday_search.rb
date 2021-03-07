require './app/services/nager_service'
require './app/poros/holiday'

class HolidaySearch
  def info
    service.holiday_info.map do |data|
      Holiday.new(data)
    end
  end

  def service
    NagerService.new
  end

  def holidays
    @holidays ||= HolidaySearch.new.info
  end
end
