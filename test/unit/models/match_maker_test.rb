require 'test_helper'

class MatchMakerTest < ActiveSupport::TestCase

  test "load team member emails" do
    organiztion = {
        'The Beatles' => ['paul@macartney.org', 'john@lennon.com', 'george@harrison.org', 'ringo@starr.org'],
        'The Quarrymen' => ['paul@macartney.org', 'john@lennon.com', 'stu@sutcliffe.org'],
        'Wings' => ['paul@macartney.org', 'linda@macartney.org'],
        'Plastic Ono Band' => ['john@lennon.com', 'yoko@ono.org'],
        'Traveling Wilburys' => ['george@harrison.org', 'tom@petty.org', 'roy@orbison.org']
    }

    match_maker = MatchMaker.seed(organiztion)
    expected_emails = ['george@harrison.org', 'john@lennon.com', 'linda@macartney.org', 'paul@macartney.org', 'ringo@starr.org', 'roy@orbison.org', 'stu@sutcliffe.org', 'tom@petty.org', 'yoko@ono.org']
    puts expected_emails.size
    assert_equal(expected_emails, match_maker.emails)
  end

  test "schedule creation for odd numer of team members" do
    expected_schedule = [[%w[a c], %w[b n/a]], [%w[a n/a], %w[b c]]]
    assert_equal expected_schedule, MatchMaker.new(%w[a b c]).schedule
  end

  test "schedule creation for even numer of team members" do
    expected_schedule = [[%w[a c], %w[b d]], [%w[a d], %w[b c]]]
    assert_equal expected_schedule, MatchMaker.new(%w[a b c d]).schedule
  end

  test "pair for each week" do
    week_0_pairs = [%w[a d], %w[b e], %w[c f]]
    week_1_pairs = [%w[a e], %w[b f], %w[c d]]
    week_2_pairs = [%w[a f], %w[b d], %w[c e]]

    assert_equal week_0_pairs, MatchMaker.new(%w[a b c d e f]).pairs(0)
    assert_equal week_1_pairs, MatchMaker.new(%w[a b c d e f]).pairs(1)
    assert_equal week_2_pairs, MatchMaker.new(%w[a b c d e f]).pairs(2)
    assert_equal week_0_pairs, MatchMaker.new(%w[a b c d e f]).pairs(3)
    assert_equal week_1_pairs, MatchMaker.new(%w[a b c d e f]).pairs(4)
    assert_equal week_2_pairs, MatchMaker.new(%w[a b c d e f]).pairs(5)
  end


end