module ConnectFour
  module CheckWin
    def self.check_win(board, row, column)
      # checking which kind of chip was placed
      @player_chip = board.board[row][column]
      @horizontal = 0
      @vertical = 0
      @diagonal = 0

      has_top, has_bot, has_left, has_right = true, true, true, true

      if column >= board.board.length
        #don't check to the has_right
        has_left = false
      end
      if column <= 0
        #don't check to the has_left
        has_left = false
      end
      if row >= board.board.length - 1
        #don't check bottom row
        has_bot = false
      end
      if row <= 0
        #don't check above
        has_top = false
      end

      check_vertical(board, row, column, has_bot, has_top)
      check_horizontal(board, row, column, has_left, has_right)
      #checkdiagonal()

      if @horizontal >= 3 || @vertical >= 3 || @diagonal >= 3
        puts ("win: h#{@horizontal}, v#{@vertical}, d#{@diagonal}")
        return true
      else
        puts ("No win; h:#{@horizontal}, v:#{@vertical}, d:#{@diagonal}")
        @horizontal = 0
        @vertical = 0
        @diagonal = 0
        return false
      end
    end

    def self.check_horizontal(board, row, column, has_left, has_right)
      #@horizontal += 1
      print "horizontal[#{row}][#{column}]"
      if has_left
        if board.board[row][column - 1] == @player_chip
          print " has_left [#{row}][#{column - 1}]  "
          @horizontal += 1
          check_horizontal(board, row, column - 1, has_left, false) # continue going left, ignore right to avoid endless loop
        end
      end

      if has_right
        if board.board[row][column + 1] == @player_chip
          print " has_right [#{row}][#{column + 1}] "
          @horizontal += 1
          check_vertical(board, row, column + 1, false, has_right) # continue going right, ignore left to avoid endless loop
        end
      end
    end
    def self.check_vertical(board, row, column, has_bot, has_top)
      #print "vertical[#{row}][#{column}]"
      if has_bot
        if board.board[row + 1][column] == @player_chip
          print " has_bot [#{row + 1}][#{column}]  "
          @vertical += 1
          check_vertical(board, row + 1, column, has_bot, false) # continue going bot, ignore top to avoid endless loop
        end
      end

      if has_top
        if board.board[row - 1][column] == @player_chip
          print " has_top [#{row - 1}][#{column}] "
          @vertical += 1
          check_vertical(board, row - 1, column, false, has_top) # continue going top, ignore bot to avoid endless loop
        end
      end
    end
  end
end
