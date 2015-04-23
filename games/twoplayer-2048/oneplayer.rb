#!/bin/ruby 

require 'matrix' 

# The board, in charge of tracking its own state
class Board 
    def initialize()
        # Boards hold 'false' for an empty cell 
        # and a number otherwise
        @board = Matrix(4, 4)
        @board.each { |elem| elem = false}
    end

    def apply_move(move) 
        nboard = Matrix(4, 4)
        case move
            when :up
                nboard = Matrix[ 
                    collapse_row(@board.column(0)),
                    collapse_row(@board.column(1)),
                    collapse_row(@board.column(2)),
                    collapse_row(@board.column(3))
                ]
            when :down
                nboard = Matrix[
                    collapse_row(@board.column(0).reverse).reverse,
                    collapse_row(@board.column(1).reverse).reverse,
                    collapse_row(@board.column(2).reverse).reverse,
                    collapse_row(@board.column(3).reverse).reverse,
                ]
            when :left
                nboard = Matrix[ 
                    collapse_row(@board.row(0)),
                    collapse_row(@board.row(1)),
                    collapse_row(@board.row(2)),
                    collapse_row(@board.row(3))
                ]
            when :right
                nboard = Matrix[ 
                    collapse_row(@board.row(0).reverse).reverse,
                    collapse_row(@board.row(1).reverse).reverse,
                    collapse_row(@board.row(2).reverse).reverse,
                    collapse_row(@board.row(3).reverse).reverse
                ]
        end

        # Update internal board
        @board = nboard
    end

    #|> (Array.fold (fun acc elem -> 
                    #match (acc, elem) with
                    #| ([], y) -> [ y ]
                    #| (Contains(f) :: xs, Contains(s)) -> 
                        #if f = s then Empty :: Contains(f + 1) :: xs
                        #else Contains(s) :: Contains(f) :: xs
                    #| (Empty :: xs, Contains(s)) -> Contains(s) :: xs) [])
    # Collapse row
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
        }
        ).reverse

        while nrow.length < row.length
            nrow << false
        end

        nrow
    end



    # Value is what user wants to plop in at (row, column)
    def place_piece(board, row, column, value)
        nboard = Matrix.build(4) { |r, c| 
            # Matching coordinate and nothing already there
            if r == row && c == column && !@board[r,c]
               value
            # The rest of the board
            else 
               @board[r,c] 
            end
        }

        # Any additional work needed?
        @board = nboard
    end
end

class Game
    def initialize()
        @board = Board.new
    end

    

    # Apply player move to board 
    
end

# Map keyboard strokes to directions


### TESTING ###

# Passing
#puts "[ #{collapse_row( [false, false, false, false] ).join(",")} ]"
##puts "#{[1,false,1].select {|e| if e then true else false end}.join(",")}"
#puts "[ #{collapse_row( [false, 1,     false, false] ).join(",")} ]"
#puts "[ #{collapse_row( [1, false, 1] ).join(",")} ]"
#puts "[ #{collapse_row( [1, 1, 2, 3] ).join(",")} ]"

test_board = Matrix[
    [ false, false, false, false ], 
    [ false, 2,     false, false ], 
    [ false, false, false, false ],
    [ false, false, false, false ]
]
puts place_piece(test_board, 0, 0, 9)
