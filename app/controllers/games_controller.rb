# frozen_string_literal: true

require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @new_word = params[:new_word]
    get_answer(@new_word)
  end

  private

  def get_answer(word)
    word_array = word.chars
    @letters = params[:letters].split(' ')
    if !(word_array - @letters).empty?
      @response = "Sorry but #{word.upcase} can't be built out of #{@letters.join(', ').upcase}"
    elsif english?(word)
      @response = "Sorry but #{word.upcase} does not seems to be a valid English word..."
    else
      @response = "Congratulations! #{word.upcase} is a valid English word!"
    end
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    content = JSON.parse(response)
    content['found']
  end
end
