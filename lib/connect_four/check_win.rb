module ConnectFour
  module CheckWin
    def self.check_win(board, row, column)
      # checking which kind of chip was placed
      @player_chip = board.board[row][column]
      horizontal_counter, vertical_counter, diagonal_counter = 0, 0, 0
      has_top, has_bottom, has_left, has_right = true, true, true, true

      has_left = !(column >= board.board.length)
      has_right = !(column <= 0)
      has_bottom = !(row >= board.board.length - 1)
      has_top = !(row <= 0)

      vertical_counter = check_vertical(board: board, row: row, column: column, has_bottom: has_bottom, has_top: has_top, counter: vertical_counter)
      horizontal_counter = check_horizontal(board: board, row: row, column: column, has_left: has_left, has_right: has_right, counter: horizontal_counter)
      #checkdiagonal()

      puts ("consecutive pieces: h#{horizontal_counter}, v#{vertical_counter}, d#{diagonal_counter}")
      counter_four? horizontal_counter, vertical_counter, diagonal_counter
    end

    def self.counter_four?(horizontal_counter, vertical_counter, diagonal_counter)
      puts ("counter_four? #{horizontal_counter}, #{vertical_counter}, #{diagonal_counter}")
      horizontal_counter >= 3 || vertical_counter >= 3 || diagonal_counter >= 3
    end

    def self.check_horizontal(board:, row:, column:, has_left:, has_right:, counter:)
      print "horizontal[#{row}][#{column}]"
      if has_left
        if board.board[row][column - 1] == @player_chip
          #print " has_left [#{row}][#{column - 1}]  "
          counter += 1
          counter = check_horizontal(board: board, row: row, column: column - 1, has_left: has_left, has_right: false, counter: counter) # continue going left, ignore right to avoid endless loop
        end
      end

      if has_right
        if board.board[row][column + 1] == @player_chip
          #print " has_right [#{row}][#{column + 1}] "
          counter += 1
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
          print " has_top [#{row - 1}][#{column}] "
          counter += 1
          has_top = !(row + 1 <= 0)
          counter = check_vertical(board: board, row: row - 1, column: column, has_bottom: false, has_top: has_top, counter: counter) # continue going top, ignore bot to avoid endless loop
        end
      end
      return counter
    end
  end
end
