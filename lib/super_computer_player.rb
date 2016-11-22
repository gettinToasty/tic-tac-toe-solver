require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    root_node = TicTacToeNode.new(game.board, mark)

    possible_moves = root_node.children.shuffle

    node = possible_moves.find { |child| child.winning_node?(mark) }
    p node
    return node.prev_move_pos if node

    node = possible_moves.find { |child| !child.losing_node?(mark) }
    return node.prev_move_pos if node

    raise
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
