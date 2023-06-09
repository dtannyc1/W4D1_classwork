require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)

    node = TicTacToeNode.new(game.board, mark)

    # for each location, do i win?
    node.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end

    # if mark == :x
    #     opponent = :o
    # else
    #     opponent = :x
    # end

    # for each location, do i not lose?
    node.children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end
    raise "There are no non losing nodes."
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
