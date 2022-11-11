require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params[:word].upcase
    grid = params[:grid].split
    @grid_print = grid.join(', ')
    @grid_valid = @word.chars.all? do |char|
      grid.delete_at(grid.index(char) || grid.length)
      # || grid.length to avoid error if char not in grid: index(char) => nil, delete_at(nil) => error
    end
    dictionary_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    dictionary = JSON.parse(dictionary_serialized)
    @dictionary_valid = dictionary['found']
  end
end
