require "connect_four/check_win"

module ConnectFour
  module Input
    module PlaceChip
      def self.place_chip(column, board)
        column = check_row_full(column, board)
        row = check_lowest_possible(column, board)
        if (board.p1_turn)
          player_chip = "x"
        else
          player_chip = "o"
        end
        board.board[row][column] = player_chip
        game_won = ConnectFour::CheckWin.check_win(board, row, column)
        if game_won
          return true
        else
          return false
        end
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

      def self.check_row_full(column, board)
        #puts "Checking if row at column #{column + 1} is full"
        if board.row_full[column + 1] == true
          puts "Row at column#{column + 1} full, invalid move."
          column = gets.chomp.to_i
          column = valid_move(column)
          check_row_full(column - 1, board)
        end
        return column
      end

      def self.valid_move(chosen_move)
        while (chosen_move < 1 || chosen_move > 8)
          puts("Invalid move, please choose a column between 1-8.")
          chosen_move = gets.chomp.to_i
        end
        return chosen_move
      end
    end
  end
end
