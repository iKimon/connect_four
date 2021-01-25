require "connect_four/board"
require "connect_four/input/place_chip"
require "connect_four/output/terminal_printer"

module ConnectFour
  def self.run
    board = ConnectFour::Board.new
    game_over = false
    while !game_over
      ConnectFour::Output::TerminalPrinter.print_board(board)
      chosen_move = gets.chomp.to_i
      chosen_move = ConnectFour::Input::PlaceChip.valid_move(chosen_move)
      ConnectFour::Input::PlaceChip.place_chip(chosen_move - 1, board)
      board.toggle_turn
      puts `clear`
    end
  end
end
