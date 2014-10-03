class MatchMaker

  attr_reader :emails

  def initialize(emails)
    @emails = emails
  end

  # create a matrix that represents the schedule for all unique pairs
  # e.g. for ['a', 'b', 'c'] the unique pairs are [['a', 'b'], ['b', 'c'], ['c', 'a']] and [['a', 'c'], ['b', 'a'], ['c', 'a']]
  def schedule
    unless (@schedule)
      schedule = []


      (1...@emails.size).each do |shifts|
        weekly_pairs = []

        second_row = Array.new(@emails)
        shifts.times { second_row << second_row.shift }
        @emails.each_with_index do |top_row_email, index|
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