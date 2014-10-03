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
    assert_equal(expected_emails, match_maker.emails)
  end

  test "schedule creation" do
    expected_schedule = [[%w[a b], %w[b c], %w[c a]], [%w[a c], %w[b a], %w[c b]]]
    assert_equal expected_schedule, MatchMaker.new(%w[a b c]).schedule
  end

  test "pair for each week" do
    week_0_pairs = [%w[a b], %w[b c], %w[c a]]
    week_1_pairs = [%w[a c], %w[b a], %w[c b]]

    assert_equal week_0_pairs, MatchMaker.new(%w[a b c]).pairs(0)
    assert_equal week_1_pairs, MatchMaker.new(%w[a b c]).pairs(1)
    assert_equal week_0_pairs, MatchMaker.new(%w[a b c]).pairs(2)
    assert_equal week_1_pairs, MatchMaker.new(%w[a b c]).pairs(3)
  end


end