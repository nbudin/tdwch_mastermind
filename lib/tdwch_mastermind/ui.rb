require 'readline'

module TdwchMastermind
  class UI
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def play_turn
      guess_string = Readline.readline("> ", true)
      exit! unless guess_string

      guess = guess_string.upcase.strip.split('')
      if error = game.get_error(guess)
        puts error
        puts
        return
      end

      response = game.check(guess)
      puts "Correct: #{response.correct_positions}    Partially correct: #{response.incorrect_positions}"
      puts

      response
    end

    def main_loop
      puts "Solution size: #{game.solution.size}"

      loop do
        response = play_turn
        next unless response

        break if response.correct_positions == game.solution.size
      end
    end
  end
end