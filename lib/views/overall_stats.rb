class OverallStats
  def initialize(data)
    @data = data
  end

  def display
    text = ''
    data.each do |row|
      name = row.fullname ? row.fullname : row.username
      pluses = '+' * row.count
      text += "#{name.strip}: #{pluses} (#{row.count})\n"
    end
  end

  private

  attr_reader :data
end