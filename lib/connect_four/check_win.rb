module ConnectFour
  module CheckWin
    def self.check_win(board, row, column)
      # checking which kind of chip was placed
      @board_length = board.board.length
      chip_position = row, column

      vertical_counter, horizontal_counter, diagonal_counter_l_to_r, diagonal_counter_r_to_l = 0, 0, 0, 0

      vertical_counter = check_vertical(board: board, chip_position: chip_position)
      horizontal_counter = check_horizontal(board: board, chip_position: chip_position)
      diagonal_counter_l_to_r = check_diagonal_l_to_r(board: board, chip_position: chip_position)
      diagonal_counter_r_to_l = check_diagonal_r_to_l(board: board, chip_position: chip_position)

      #puts ("consecutive pieces: h#{horizontal_counter}, v#{vertical_counter}, dLR#{diagonal_counter_l_to_r} dRL#{diagonal_counter_r_to_l}")
      any_counter_four?(horizontal_counter, vertical_counter, diagonal_counter_l_to_r, diagonal_counter_r_to_l)
    end

    def self.any_counter_four?(horizontal_counter, vertical_counter, diagonal_counter_l_to_r, diagonal_counter_r_to_l)
      horizontal_counter >= 3 || vertical_counter >= 3 || diagonal_counter_l_to_r >= 3 || diagonal_counter_r_to_l >= 3
    end

    def self.check_horizontal(board:, chip_position:)
      counter = 0
      initial_position = chip_position.dup  # Fragen: correct use of dup?

      if has_left?(chip_position)
        while left_slot_equal_playerchip?(chip_position, board)
          counter += 1
          chip_position[1] -= 1 # keep checking to the left
        end
      end

      chip_position = initial_position

      if has_right?(chip_position)
        while right_slot_equal_playerchip?(chip_position, board)
          counter += 1
          chip_position[1] += 1   # keep checking to the right
        end
      end
      return counter
    end

    def self.check_vertical(board:, chip_position:)
      counter = 0
      initial_position = chip_position.dup

      if has_bottom?(chip_position)
        while bottom_slot_equal_playerchip?(chip_position, board)
          counter += 1
          chip_position[0] += 1
          if !has_bottom?(chip_position)
            break
          end
        end
      end

      chip_position = initial_position

      if has_top?(chip_position)
        while top_slot_equal_playerchip?(chip_position, board)
          counter += 1
          chip_position[0] -= 1
          if !has_top?(chip_position)
            break
          end
        end
      end
      return counter
    end

    def self.check_diagonal_l_to_r(board:, chip_position:)
      counter_l_to_r = 0
      initial_position = chip_position.dup

      if has_top?(chip_position)
        if has_left?(chip_position)
          while top_left_slot_equal_playerchip?(chip_position, board)
            counter_l_to_r += 1
            chip_position[0] -= 1
            chip_position[1] -= 1
            if !has_top?(chip_position) || !has_left?(chip_position)
              break
            end
          end
        end
      end

      chip_position = initial_position

      if has_bottom?(chip_position)
        if has_right?(chip_position)
          while bottom_right_slot_equal_playerchip?(chip_position, board)
            counter_l_to_r += 1
            chip_position[0] += 1
            chip_position[1] += 1
            if !has_bottom?(chip_position) || !has_right?(chip_position)
              break
            end
          end
        end
      end
      return counter_l_to_r
    end

    def self.check_diagonal_r_to_l(board:, chip_position:)
      counter_r_to_l = 0
      initial_position = chip_position.dup

      if has_top?(chip_position)
        if has_right?(chip_position)
          while top_right_slot_equal_playerchip?(chip_position, board)
            counter_r_to_l += 1
            chip_position[0] -= 1
            chip_position[1] += 1
            if !has_top?(chip_position) || !has_right?(chip_position)
              break
            end
          end
        end
      end

      chip_position = initial_position

      if has_bottom?(chip_position)
        if has_left?(chip_position)
          while bottom_left_slot_equal_playerchip?(chip_position, board)
            counter_r_to_l += 1
            chip_position[0] += 1
            chip_position[1] -= 1
            if !has_bottom?(chip_position) || !has_left?(chip_position)
              break
            end
          end
        end
      end
      return counter_r_to_l
    end

    def self.has_left?(chip_position)
      !(chip_position[1] >= @board_length)
    end

    def self.has_right?(chip_position)
      !(chip_position[1] <= 0)
    end

    def self.has_top?(chip_position)
      !(chip_position[0] <= 0)
    end

    def self.has_bottom?(chip_position)
      !(chip_position[0] >= @board_length - 1)
    end

    def self.left_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0]][chip_position[1] - 1] == board.board[chip_position[0]][chip_position[1]]
    end

    def self.right_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0]][chip_position[1] + 1] == board.board[chip_position[0]][chip_position[1]]
    end

    def self.bottom_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0] + 1][chip_position[1]] == board.board[chip_position[0]][chip_position[1]]
    end

    def self.top_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0] - 1][chip_position[1]] == board.board[chip_position[0]][chip_position[1]]
    end

    def self.top_left_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0] - 1][chip_position[1] - 1] == board.board[chip_position[0]][chip_position[1]]
    end

    def self.top_right_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0] - 1][chip_position[1] + 1] == board.board[chip_position[0]][chip_position[1]]
    end

    def self.bottom_left_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0] + 1][chip_position[1] - 1] == board.board[chip_position[0]][chip_position[1]]
    end

    def self.bottom_right_slot_equal_playerchip?(chip_position, board)
      board.board[chip_position[0] + 1][chip_position[1] + 1] == board.board[chip_position[0]][chip_position[1]]
    end
  end
end
