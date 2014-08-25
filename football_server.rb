require 'sinatra'
require 'pry'

# I can navigate to a page /leaderboard to view the summary of the league.
# Each team is displayed on this page.
# For each team, I can see how many wins and losses they have.
# start with posting original array
# then we are going to have to break down each one and differentiate
#between home team and away team while accessing the scores
# For this we will create hash and use has_key?
# then once we create hash that has team and wins and losses
# we have to then assign each team win and loss total and for this I
# am still unsure how
scoreboard =
[
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]

team_record = Hash.new

scoreboard.each do |row|
    if team_record.has_key?(row[:home_team])
      team_record[row[:home_team]] = Hash.new
      team_record[row[:home_team]][:wins] = 0
      team_record[row[:home_team]][:losses] = 0
    else team_record.has_key?(row[:away_team])
      team_record[row[:away_team]] = Hash.new
      team_record[row[:away_team]][:wins] = 0
      team_record[row[:away_team]][:losses] = 0
    end
end

scoreboard.each do |row|
    if team_record.has_key?(row[:home_team])
      if row[:home_score] > row[:away_score]
        team_record[row[:home_team]][:wins] += 1
        team_record[row[:away_team]][:losses] += 1
      else
        team_record[row[:home_team]][:losses] += 1
        team_record[row[:away_team]][:wins] += 1
      end
    end
end

before do
  @team_record = team_record
end

get '/' do
erb :index_football
end

get '/leaderboard' do
@team_record
erb :show_football
end


set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
