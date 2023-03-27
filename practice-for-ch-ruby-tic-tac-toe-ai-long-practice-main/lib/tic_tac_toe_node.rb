require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
    attr_reader :board, :next_mover_mark, :prev_move_pos

    def initialize(board, next_mover_mark, prev_move_pos = nil)
        @board = board
        @next_mover_mark = next_mover_mark
        @prev_move_pos = prev_move_pos
    end

    def losing_node?(evaluator)
        return true if @board.over? &&
                     ((@board.winner != evaluator) && !@board.winner.nil?)
        return false if @board.over? && @board.winner == evaluator
        all_children = self.children

        return true if next_mover_mark == evaluator &&
                       all_children.all? do |child|
                            child.losing_node?(evaluator)
                       end
        return true if next_mover_mark != evaluator &&
                        all_children.any? do |child|
                            child.losing_node?(evaluator)
                        end
        false
    end

    def winning_node?(evaluator)
        # @board.over? && @board.winner == evaluator
    end

    # This method generates an array of all moves that can be made after
    # the current move.
    def children
        all_children = []
        @board.open_positions.each do |position|
            new_board = @board.dup
            new_board[position] = @next_mover_mark
            # node = TicTacToeNode.new(new_board, new_board.next_mark, position)
            if @next_mover_mark == :x
                next_mark = :o
            else
                next_mark = :x
            end
            node = TicTacToeNode.new(new_board, next_mark, position)
            all_children << node
        end
        all_children
    end
end
