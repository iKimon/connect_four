module ConnectFour
  module Output
    module TerminalPrinter
      def green; "\e[32m#{self}\e[0m" end
      def blue; "\e[34m#{self}\e[0m" end

      def self.print_board(board)
        #puts(board.board)
        board.board.length.times { |times|
          board.board[times].each { |each|
            if each == "x"
              print "\e[32m#{each}\e[0m"
            elsif each == "o"
              print "\e[34m#{each}\e[0m"
            else
              print each
            end
            print " "
          }; print "\n"
        }

        puts("1 2 3 4 5 6 7 8")
        if (board.p1_turn)
          puts("Player number 1's turn.")
        else
          puts("Player number 2's turn.")
        end
      end
    end
  end
end
