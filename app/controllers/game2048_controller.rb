#!/bin/ruby 

require 'matrix'
require 'io/console'

# Board is immutable. State change operations return a new Board
# Boards hold 'false' for an empty cell
# and a number otherwise
class Board
  def board
    return @board
  end

  def apply_move(move) 
    nboard = Matrix.build(4, 4)
    case move
    when :up
      nboard = Matrix.columns([
        collapse_row(@board.column(0)),
        collapse_row(@board.column(1)),
        collapse_row(@board.column(2)),
        collapse_row(@board.column(3))
        ])
    when :down
      nboard = Matrix.columns([
        collapse_row(@board.column(0).to_a.reverse).reverse,
        collapse_row(@board.column(1).to_a.reverse).reverse,
        collapse_row(@board.column(2).to_a.reverse).reverse,
        collapse_row(@board.column(3).to_a.reverse).reverse,
        ])
    when :left
      nboard = Matrix[ 
        collapse_row(@board.row(0)),
        collapse_row(@board.row(1)),
        collapse_row(@board.row(2)),
        collapse_row(@board.row(3))
      ]
    when :right
      nboard = Matrix[ 
        collapse_row(@board.row(0).to_a.reverse).reverse,
        collapse_row(@board.row(1).to_a.reverse).reverse,
        collapse_row(@board.row(2).to_a.reverse).reverse,
        collapse_row(@board.row(3).to_a.reverse).reverse
      ]
      # TODO: todofunction adds another symbol
      # for when move is invalid, and user must try again
    when :broken
      @board
    end

    def !=(board)
      !(@board == board.board)
    end

    Board.new(nboard)
  end

  def collapse_row(row)
    nrow =
    (row.select {|e| if e then true else false end}.inject([]) {|acc,elem| 
      if acc.length == 0 
        [elem]
      elsif acc[0]
        if acc[0] == elem 
          [false,elem+1].concat(acc[1..-1])
        else
          acc.unshift(elem)
        end
            else # 0::xs,#
              acc[1..-1].unshift(elem)
            end
            }).reverse

    while nrow.size < row.size
      nrow << false
    end

    nrow.to_a
  end

    # Value is what user wants to plop in at (row, column)
    # Will return an identical board if a piece is already present (Check using !=)
    def place_piece(row, column, value)
      nboard = Matrix.build(4) { |r, c|
            # Matching coordinate and nothing already there
            if r == row && c == column && !@board[r,c]
             value
            # The rest of the board
          else 
           @board[r,c] 
         end
       }

       Board.new(nboard)
     end

     def print
      str = ""
      @board.row_size.times do |i|
        str += @board.row(i).to_a.join(",") + "\n"
      end
      str
    end
  def initialize(matrix=nil)
    if matrix
      @board = matrix
    else
      @board = Matrix.build(4, 4) {|r,c|
                if(r==0 && c==0)
                    1
                elsif (r==0 && c==1)
                    1
                else
                    false
                end
            }
    end
  end
  end

  class Game
    public
    # Scaffolding for commandline 2048 (one board)
    def play()
      currentboard = Board.new
      currentboard.print
      loop do
        loop do
          nextboard = currentboard.apply_move(key2sym(read_char))
          if nextboard != currentboard
            currentboard = nextboard
            break
          end
        end
        currentboard.print
        loop do 
          puts "Place a piece."
          print "RCV: "
          input = gets.chomp.split("").map {|elem| elem.to_i}
                # input validation
                if (input[0] >= 0 && input[0] < 4 && input[1] >= 0 && input[1] < 4 && (input[2] == 1 || input[2] == 2))
                  nextboard = currentboard.place_piece(*input)
                  if (nextboard != currentboard)
                    currentboard = nextboard 
                    currentboard.print
                    break
                  end
                end
              end
            end
          end

          private
    # Read in keyboard input
    # Original from https://gist.github.com/acook/4190379
    def read_char
      STDIN.echo = false
      STDIN.raw!

      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!

      return input
    end
    def key2sym(input_char)
      case input_char
      when "\e[A"
        :up
      when "\e[B"
        :down
      when "\e[C"
        :right
      when "\e[D"
        :left
        # TODO: Add "quit" key 
      end
    end
  end

class Game2048Controller < ApplicationController
  # TODO: Single game at one time for now
  def initialize
    @p1board = Board.new
    @p2board = Board.new
    @player1turn = true
  end

  # Display updated board
  def show
    @board1 = @p1board.print
    @board2 = @p2board.print
  end

  # Move and place piece
  def move
    dir = params[:dir]
    row = params[:row]
    col = params[:col]
    val = params[:val]
    # Move and place piece must both be valid until turn ends
    if(@player1turn)
       # TODOFUNCTION converts form's move direction ("up") 
       # to symbol (:up)
      @p1board = @p1board.apply_move(TODOFUNCTION(dir))
      @p2board = @p2board.place_piece(row.to_i,col.to_i,val.to_i)
    else
      @p2board = @p2board.apply_move(TODOFUNCTION(dir))
      @p1board = @p1board.place_piece(row.to_i,col.to_i,val.to_i)
    end
    @player1turn = !@player1turn
  end
end
