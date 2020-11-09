class GamesController < ApplicationController
  def new
    chars = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << chars[rand(chars.length - 1)] }
  end

  def score
    # 1. stocker le params[:word] et le params[:letters] dans 2 variables avec un @
    @submit = params[:word].to_s
    @split_submit = params[:word].upcase.split('')
    @letters = params[:letters]
    # 2. creer une methode => si words est contenu dans letters
    @in_grid = included?(@submit, @letters)
    # 3. creer une methode => si word est bien un mot anglais
    @is_english = english_word?(@submit)
  end

  private

  def included?(word, grid)
    @split_submit.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(keyword)
    require 'json'
    require 'open-uri'
    url = "https://wagon-dictionary.herokuapp.com/#{keyword}"
    JSON.parse(open(url).read)['found']
  end
end
