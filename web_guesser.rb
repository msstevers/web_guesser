require 'sinatra'
require 'sinatra/reloader'
# this is the class we define
class WebGuesser
  attr_reader :number, :response
  def initialize
    @number = rand(101)
    @response = {
      too_high: 'Too high',
      way_too_high: 'Way too high',
      too_low: 'Too low',
      way_too_low: 'Way too low',
      correct: 'correct!'
    }
  end

  def build_response(guess)
    return response[:too_high] if guess > number
    return response[:too_low] if guess < number
    return response[:correct] if guess == number
  end
end

web_guesser = WebGuesser.new

get '/' do
  guess = params['guess'].to_i
  erb :index,
      locals:
    { number: web_guesser.number,
      message: web_guesser.build_response(guess),
      guess: guess }
end
