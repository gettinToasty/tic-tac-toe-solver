require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :next_mover_mark, :board, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return @board.won? && @board.winner != evaluator if @board.over?

    if evaluator == @next_mover_mark
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?

    if evaluator == @next_mover_mark
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    find_empty_spaces.each do |pos|
      dup_board = @board.dup
      dup_board[pos] = @next_mover_mark
      mark = @next_mover_mark == :x ? :o : :x
      children << TicTacToeNode.new(dup_board, mark, pos)
    end

    children
  end

  def find_empty_spaces
    empty_spaces = []
    @board.rows.each_with_index do |row, i|
      row.each_index do |j|
        empty_spaces << [i, j] if @board.empty?([i, j])
      end
    end
    empty_spaces
  end
end
