module ConnectFour
  class Board
    attr_reader :board
    attr_reader :p1_turn
    attr_reader :row_full

    def initialize
      @board = Array.new(8) { Array.new(8) { "." } }
      @row_full = Array.new(8, false)
      @p1_turn = false
    end

    def toggle_turn
      @p1_turn = !@p1_turn
    end

    def place_chip(chosen_move)
      ConnectFour::Input::PlaceChip.place_chip(chosen_move - 1, board)
    end

    def print_board
      ConnectFour::Output::TerminalPrinter.print_board(board)
    end
  end
end
