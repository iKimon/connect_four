require "connect_four/board"
require "connect_four/input/place_chip"
require "connect_four/output/terminal_printer"

module ConnectFour
  def self.run
    board = ConnectFour::Board.new
    game_over = false

    while !game_over
      board.toggle_turn
      ConnectFour::Output::TerminalPrinter.print_board(board)
      chosen_move = gets.chomp.to_i
      chosen_move = ConnectFour::Input::PlaceChip.get_valid_move(chosen_move, board)
      game_over = ConnectFour::Input::PlaceChip.place_chip(chosen_move - 1, board)
      #puts `clear`
    end
    ConnectFour::Output::TerminalPrinter.print_board(board)
    if board.p1_turn
      puts "Player 1 won, congratulations!"
    else
      puts "Player 2 won, congratulations!"
    end
  end
end
