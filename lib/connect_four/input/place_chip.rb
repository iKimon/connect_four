require "connect_four/check_win"

module ConnectFour
  module Input
    module PlaceChip
      BOARD_MIN_DIMENSION = 1
      BOARD_MAX_DIMENSION = 8

      def self.place_chip(column, board)
        #column = check_row_full(column, board)
        row = check_lowest_possible(column, board)
        if (board.p1_turn)
          player_chip = "x"
        else
          player_chip = "o"
        end
        board.board[row][column] = player_chip
        game_won = ConnectFour::CheckWin.check_win(board, row, column)
      end

      def self.check_lowest_possible(column, board)
        i = board.board.length - 1
        while i >= 0
          #print("checking row #{i}: column #{column};  Element: #{board.board[i][column]} \n")
          if board.board[i][column] == "."
            if i == 0
              board.row_full[column + 1] = true
              #puts "Row #{column + 1} now full."
            end
            return i
          end
          i -= 1
        end
      end

      def self.check_row_full?(column, board)
        puts "Checking if row at column #{column + 1} is full"
        board.row_full[column + 1]
      end

      def self.get_valid_move(chosen_move, board)
        #if (valid_move?(chosen_move) && !check_row_full?(chosen_move))
        if valid_move? chosen_move, board
          return chosen_move  # Frage: Return umgeghen?
        else
          puts "Invalid move, please choose a number between 1-8."
          chosen_move = gets.to_i
          get_valid_move(chosen_move, board)
        end
      end

      def self.valid_move?(chosen_move, board)
        chosen_move >= BOARD_MIN_DIMENSION && chosen_move <= BOARD_MAX_DIMENSION && !board.row_full[chosen_move]
      end
    end
  end
end
