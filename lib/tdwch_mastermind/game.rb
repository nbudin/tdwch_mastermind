require 'set'

module TdwchMastermind
  class Game
    attr_reader :allowed_letters, :solution, :solution_letter_frequencies

    def initialize(allowed_letters, solution)
      @allowed_letters = allowed_letters.map(&:upcase)
      @solution = solution.map(&:upcase)
      @solution_letter_frequencies = letter_frequencies(solution)
    end

    def check(guess)
      correct_positions = solution.zip(guess).count { |(solution_letter, guess_letter)| solution_letter == guess_letter }
      guess_letter_frequencies = letter_frequencies(guess)
      correct_letters = guess_letter_frequencies.inject(0) do |count, (letter, frequency)|
        count + [frequency, solution_letter_frequencies[letter]].min
      end

      Response.new(guess, correct_positions, correct_letters - correct_positions)
    end

    def get_error(guess)
      if guess.size != solution.size
        return "Please enter a guess with #{solution.size} letters."
      end

      unless guess.all? { |letter| allowed_letters.include?(letter) }
        return "Please enter a guess containing only the letters #{allowed_letters.join(', ')}."
      end
    end

    private
    def letter_frequencies(solution)
      solution.inject(Hash.new(0)) do |hash, letter|
        hash[letter] += 1
        hash
      end
    end
  end
end
