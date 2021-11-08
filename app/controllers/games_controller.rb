require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = randomize
  end

  def score
    @word = params[:word]
    @play_field = params[:letters]
    @message = ""
    @message = "Sorry but #{@word} cannot be build with #{@play_field}" unless valid_word?(@word)
    @message = "Congratulations! #{@word} is a valid English word." if valid_word?(@word) && dictionary?(@word)
    @message = "Sorry but #{@word} does not seem like a valid English word..." unless dictionary?(@word)
  end

  private

  def randomize
    'A'.upto('Z').to_a.sample(10)
  end

  def dictionary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    dictionary_call = URI.open(url).read
    JSON.parse(dictionary_call)['found']
  end

  def valid_word?(word)
    word.chars.all? { |char| @play_field.include?(char.upcase) }
  end
end
