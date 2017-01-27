module TdwchMastermind
  class Response
    attr_reader :guess, :correct_positions, :incorrect_positions

    def initialize(guess, correct_positions, incorrect_positions)
      @guess = guess
      @correct_positions = correct_positions
      @incorrect_positions = incorrect_positions
    end
  end
end