class MatchMaker

  attr_reader :emails

  def initialize(emails)
    @emails = emails
  end

  # create a matrix that represents the schedule for all unique pairs
  # e.g. for ['a', 'b', 'c'] the unique pairs are [['a', 'c'], ['b', 'n/a']] and [['a', 'n/a'], ['b', 'c']]
  def schedule
    unless (@schedule)
      schedule = []
      emails = @emails
      emails << 'n/a' if @emails.size.odd?

      top_row = emails[0...(emails.size/2)]
      (0...top_row.size).each do |shifts|
        weekly_pairs = []
        second_row = emails[(emails.size/2)...emails.size]

        shifts.times {second_row << second_row.shift}
        top_row.each_with_index do |top_row_email, index|
          weekly_pairs << [top_row_email, second_row[index]]
        end

        schedule << weekly_pairs
      end

      @schedule = schedule

    end

    @schedule
  end

  def pairs(week)
    number_of_unique_pairs = schedule.size
    schedule[week % number_of_unique_pairs]
  end

  def self.seed(teams)
    emails = teams.values.flatten.uniq.sort

    MatchMaker.new(emails)
  end

end