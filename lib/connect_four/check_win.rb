require "pry"

module ConnectFour
  module CheckWin
    def self.check_win(board, row, column)
      # checking which kind of chip was placed
      @player_chip = board.board[row][column]
      #horizontal_counter, vertical_counter, diagonal_counter = 0, 0, 0
      has_top, has_bottom, has_left, has_right = true, true, true, true

      has_left = !(column >= board.board.length)
      has_right = !(column <= 0)
      has_bottom = !(row >= board.board.length - 1)
      has_top = !(row <= 0)

      vertical_counter = check_vertical(board: board, row: row, column: column, has_bottom: has_bottom, has_top: has_top, counter: 0)
      horizontal_counter = check_horizontal(board: board, row: row, column: column, has_left: has_left, has_right: has_right, counter: 0)
      diagonal_counter_l_to_r = check_diagonal_l_to_r(board: board, row: row, column: column, has_bottom: has_bottom, has_top: has_top, has_left: has_left, has_right: has_right, counter_r_to_l: 0, counter_l_to_r: 0)
      diagonal_counter_r_to_l = check_diagonal_r_to_l(board: board, row: row, column: column, has_bottom: has_bottom, has_top: has_top, has_left: has_left, has_right: has_right, counter_r_to_l: 0, counter_l_to_r: 0)

      puts ("consecutive pieces: h#{horizontal_counter}, v#{vertical_counter}, dLR#{diagonal_counter_l_to_r} dRL#{diagonal_counter_r_to_l}")
      counter_four? horizontal_counter, vertical_counter, diagonal_counter_l_to_r, diagonal_counter_r_to_l
    end

    def self.counter_four?(horizontal_counter, vertical_counter, diagonal_counter_l_to_r, diagonal_counter_r_to_l)
      #puts ("counter_four? #{horizontal_counter}, #{vertical_counter}, dLR#{diagonal_counter_l_to_r}, dRL#{diagonal_counter_r_to_l} ")
      horizontal_counter >= 3 || vertical_counter >= 3 || diagonal_counter_l_to_r >= 3 || diagonal_counter_r_to_l >= 3
    end

    def self.check_horizontal(board:, row:, column:, has_left:, has_right:, counter:)
      #print "horizontal[#{row}][#{column}]"
      if has_left
        if board.board[row][column - 1] == @player_chip
          #print " has_left [#{row}][#{column - 1}]  "
          counter += 1
          has_left = !(column - 1 >= board.board.length)
          counter = check_horizontal(board: board, row: row, column: column - 1, has_left: has_left, has_right: false, counter: counter) # continue going left, ignore right to avoid endless loop
        end
      end

      if has_right
        if board.board[row][column + 1] == @player_chip
          #print " has_right [#{row}][#{column + 1}] "
          counter += 1
          has_right = !(column + 1 <= 0)
          counter = check_horizontal(board: board, row: row, column: column + 1, has_left: false, has_right: has_right, counter: counter) # continue going right, ignore left to avoid endless loop
        end
      end
      return counter
    end

    def self.check_vertical(board:, row:, column:, has_bottom:, has_top:, counter:)
      if has_bottom
        if board.board[row + 1][column] == @player_chip
          #print " has_bottom [#{row + 1}][#{column}]  "
          counter += 1
          has_bottom = !(row + 1 >= board.board.length - 1)
          counter = check_vertical(board: board, row: row + 1, column: column, has_bottom: has_bottom, has_top: false, counter: counter) # continue going bot, ignore top to avoid endless loop
        end
      end

      if has_top
        if board.board[row - 1][column] == @player_chip
          #print " has_top [#{row - 1}][#{column}] "
          counter += 1
          has_top = !(row + 1 <= 0)
          counter = check_vertical(board: board, row: row - 1, column: column, has_bottom: false, has_top: has_top, counter: counter) # continue going top, ignore bot to avoid endless loop
        end
      end
      return counter
    end

    def self.check_diagonal_l_to_r(board:, row:, column:, has_bottom:, has_top:, has_left:, has_right:, counter_r_to_l:, counter_l_to_r:)
      if has_top
        if has_left
          if board.board[row - 1][column - 1] == @player_chip
            counter_l_to_r += 1
            print " #{counter_l_to_r} "
            has_top = !(row + 1 <= 0)
            has_left = !(column - 1 >= board.board.length)
            counter_l_to_r = check_diagonal_l_to_r(board: board, row: row - 1, column: column - 1, has_bottom: false, has_top: has_top, has_left: has_left, has_right: false, counter_r_to_l: counter_r_to_l, counter_l_to_r: counter_l_to_r)
          end
        end
      end
      if has_bottom
        if has_right
          if board.board[row + 1][column + 1] == @player_chip
            counter_l_to_r += 1
            print " #{counter_l_to_r} "
            has_bottom = !(row + 1 >= board.board.length - 1)
            has_right = !(column + 1 <= 0)
            counter_l_to_r = check_diagonal_l_to_r(board: board, row: row + 1, column: column + 1, has_bottom: has_bottom, has_top: false, has_left: false, has_right: has_right, counter_r_to_l: counter_r_to_l, counter_l_to_r: counter_l_to_r)
          end
        end
      end
      "Returning #{counter_l_to_r} "
      return counter_l_to_r
    end

    def self.check_diagonal_r_to_l(board:, row:, column:, has_bottom:, has_top:, has_left:, has_right:, counter_r_to_l:, counter_l_to_r:)
      #print " dia"
      if has_top
        #print "t"
        if has_right
          if board.board[row - 1][column + 1] == @player_chip
            counter_r_to_l += 1
            print " #{counter_r_to_l} "
            has_top = !(row + 1 <= 0)
            has_right = !(column + 1 <= 0)
            counter_r_to_l = check_diagonal_r_to_l(board: board, row: row - 1, column: column + 1, has_bottom: false, has_top: has_top, has_left: false, has_right: has_right, counter_r_to_l: counter_r_to_l, counter_l_to_r: counter_l_to_r)
          end
        end
      end
      if has_bottom
        if has_left
          if board.board[row + 1][column - 1] == @player_chip
            counter_r_to_l += 1
            print " #{counter_r_to_l} "
            has_bottom = !(row + 1 >= board.board.length - 1)
            has_left = !(column - 1 >= board.board.length)
            counter_r_to_l = check_diagonal_r_to_l(board: board, row: row + 1, column: column - 1, has_bottom: has_bottom, has_top: false, has_left: has_left, has_right: false, counter_r_to_l: counter_r_to_l, counter_l_to_r: counter_l_to_r)
          end
          #check bottom left
        end
      end
      "Returning #{counter_r_to_l} "
      return counter_r_to_l
    end
  end
end

#{diagonal_counter}
