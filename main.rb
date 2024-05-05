require_relative "pieces.rb"
require_relative "draw.rb"

# Beskrivning: Returnerar hur många poäng en pjäs är värd
# Argument 1: Piece
# Return: Integer: poängvärdet av pjäsen
# Exempel:
#       piece_to_points(Pawn) => 1
#       piece_to_points(Knight) => 3
#       piece_to_points(Bishop) => 3
#       piece_to_points(Rook) => 5
#       piece_to_points(Queen) => 9
# Noah Westerberg
# Datum 4/5/2024
def piece_to_points(piece)
    if piece.class == Pawn
        return 1
    elsif piece.class == Knight || piece.class == Bishop
        return 3
    elsif piece.class == Rook
        return 5
    elsif piece.class == Queen
        return 9
    end
end

Player = Struct.new(:name, :color) do
    # Beskrivning: Returnerar hur många poäng spelaren har
    # Argument 1: 2D-Array: Spelbrädan
    # Return: Integer
    # Exempel: 
    # Datum 5/5/2024
    # Namn: Noah Westerberg
    def points(board)
        points = 0
        for row in board
            for piece in row
                if piece.class != Empty
                    if piece.color == color
                        points += piece_to_points(piece)
                    end
                end
            end
        end
        return points
    end
end

# Beskrivning: Initializera spelarna
# Return: Array: spelarna
# Exempel: [
#       #<struct Player name="Player 1", color="white">, 
#       #<struct Player name="Player 2", color="black">]
# Datum: 5/5/2024
# Namn: Noah Westerberg
def initialize_players()
    player1 = Player.new("Player 1", "white")
    player2 = Player.new("Player 2", "black")
    return [player1, player2]
end

# Beskrivning: Initializerar spelbrädan
# Return 2D-Array: spelbrädan
# Exempel: [[#<Rook:0x0000029b2c237228 @icon="R", @color="white", @position=#<struct Vector2 x=0, y=0>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c236ff8 @icon="Kn", @color="white", @position=#<struct Vector2 x=1, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236f58 @icon="B", @color="white", @position=#<struct Vector2 x=2, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Queen:0x0000029b2c236e18 @icon="Q", @color="white", @position=#<struct Vector2 x=3, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<King:0x0000029b2c236eb8 @icon="K", @color="white", @position=#<struct Vector2 x=4, y=0>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236f08 @icon="B", @color="white", @position=#<struct Vector2 x=5, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c236fa8 @icon="Kn", @color="white", @position=#<struct Vector2 x=6, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Rook:0x0000029b2c237048 @icon="R", @color="white", @position=#<struct Vector2 x=7, y=0>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>], [#<Pawn:0x0000029b2c236d78 @icon="P", @color="white", @position=#<struct Vector2 x=0, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236d28 @icon="P", @color="white", @position=#<struct Vector2 x=1, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236c88 @icon="P", @color="white", @position=#<struct Vector2 x=2, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236c38 @icon="P", @color="white", @position=#<struct Vector2 x=3, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236be8 @icon="P", @color="white", @position=#<struct Vector2 x=4, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236b98 @icon="P", @color="white", @position=#<struct Vector2 x=5, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236af8 @icon="P", @color="white", @position=#<struct Vector2 x=6, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236aa8 @icon="P", @color="white", @position=#<struct Vector2 x=7, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>], [#<Empty:0x0000029b2c0fc520 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc3b8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc318 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc228 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc160 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbf80 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbee0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbe18 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Empty:0x0000029b2c0fbda0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbc60 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbb48 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbaa8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fba30 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb918 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb878 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb800 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Empty:0x0000029b2c0fb760 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb6c0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb5f8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb580 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb508 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb490 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb418 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb3a0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Empty:0x0000029b2c0fb328 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb288 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb1c0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb0f8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb080 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fafe0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0faf68 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0faef0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Pawn:0x0000029b2c2360f8 @icon="P", @color="black", @position=#<struct Vector2 x=0, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c2360a8 @icon="P", @color="black", @position=#<struct Vector2 x=1, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c236008 @icon="P", @color="black", @position=#<struct Vector2 x=2, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235fb8 @icon="P", @color="black", @position=#<struct Vector2 x=3, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235f18 @icon="P", @color="black", @position=#<struct Vector2 x=4, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235ec8 @icon="P", @color="black", @position=#<struct Vector2 x=5, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235e28 @icon="P", @color="black", @position=#<struct Vector2 x=6, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235dd8 @icon="P", @color="black", @position=#<struct Vector2 x=7, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>], [#<Rook:0x0000029b2c2365f8 @icon="R", @color="black", @position=#<struct Vector2 x=0, y=7>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c236558 @icon="Kn", @color="black", @position=#<struct Vector2 x=1, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236468 @icon="B", @color="black", @position=#<struct Vector2 x=2, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Queen:0x0000029b2c236148 @icon="Q", @color="black", @position=#<struct Vector2 x=3, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<King:0x0000029b2c2361e8 @icon="K", @color="black", @position=#<struct Vector2 x=4, y=7>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236238 @icon="B", @color="black", @position=#<struct Vector2 x=5, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c2364b8 @icon="Kn", @color="black", @position=#<struct Vector2 x=6, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Rook:0x0000029b2c2365a8 @icon="R", @color="black", @position=#<struct Vector2 x=7, y=7>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>]]
# Datum 5/5/2024
# Namn: Noah Westerberg
def initialize_board()
    board = [
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new]
        ]

    # white pieces
    board[0][0] = Rook.new(Vector2.new(0, 0), "white")
    board[0][7] = Rook.new(Vector2.new(7, 0), "white")
    board[0][1] = Knight.new(Vector2.new(1, 0), "white")
    board[0][6] = Knight.new(Vector2.new(6, 0), "white")
    board[0][2] = Bishop.new(Vector2.new(2, 0), "white")
    board[0][5] = Bishop.new(Vector2.new(5, 0), "white")
    board[0][4] = King.new(Vector2.new(4, 0), "white")
    board[0][3] = Queen.new(Vector2.new(3, 0), "white")
    board[1][0] = Pawn.new(Vector2.new(0, 1), "white")
    board[1][1] = Pawn.new(Vector2.new(1, 1), "white")
    board[1][2] = Pawn.new(Vector2.new(2, 1), "white")
    board[1][3] = Pawn.new(Vector2.new(3, 1), "white")
    board[1][4] = Pawn.new(Vector2.new(4, 1), "white")
    board[1][5] = Pawn.new(Vector2.new(5, 1), "white")
    board[1][6] = Pawn.new(Vector2.new(6, 1), "white")
    board[1][7] = Pawn.new(Vector2.new(7, 1), "white")

    # black pieces
    board[7][0] = Rook.new(Vector2.new(0, 7), "black")
    board[7][7] = Rook.new(Vector2.new(7, 7), "black")
    board[7][1] = Knight.new(Vector2.new(1, 7), "black")
    board[7][6] = Knight.new(Vector2.new(6, 7), "black")
    board[7][2] = Bishop.new(Vector2.new(2, 7), "black")
    board[7][5] = Bishop.new(Vector2.new(5, 7), "black")
    board[7][4] = King.new(Vector2.new(4, 7), "black")
    board[7][3] = Queen.new(Vector2.new(3, 7), "black")
    board[6][0] = Pawn.new(Vector2.new(0, 6), "black")
    board[6][1] = Pawn.new(Vector2.new(1, 6), "black")
    board[6][2] = Pawn.new(Vector2.new(2, 6), "black")
    board[6][3] = Pawn.new(Vector2.new(3, 6), "black")
    board[6][4] = Pawn.new(Vector2.new(4, 6), "black")
    board[6][5] = Pawn.new(Vector2.new(5, 6), "black")
    board[6][6] = Pawn.new(Vector2.new(6, 6), "black")
    board[6][7] = Pawn.new(Vector2.new(7, 6), "black")

    return board
end

# Beskrivning: Omvandlar en rutbetäckning till cordinater
# Argument 1: String: rutbetöckning. De första två karaktärerna ska vara rutbetäckningen 
# Return: Vector2: cordinater. nil: error
# Exempel:
#       square_to_coordinets("a1") => (0, 0)
#       square_to_coordinets("h8") => (7, 7) 
#       square_to_coordinets("e4") => (4, 4)     
#       square_to_coordinets("E4") => (4, 4) 
#       square_to_coordinets("N2") => nil
#       square_to_coordinets("cb") => nil
#       square_to_coordinets("d0") => nil
# Datum: 2/5/2024
# Namn: Noah Westerberg
def square_to_coordinets(square)
    if (square.length < 2)
        return nil
    end
    
    x = 0
    y = square[1].to_i - 1 
    if y < 0
        return nil
    end
    column = square[0].downcase
    if column == "a"
        x = 0
    elsif column == "b"
        x = 1
    elsif column == "c"
        x = 2
    elsif column == "d"
        x = 3
    elsif column == "e"
        x = 4
    elsif column == "f"
        x = 5
    elsif column == "g"
        x = 6
    elsif column == "h"
        x = 7
    else
        return nil
    end

    return Vector2.new(x, y)
end

# Beskrivning:
# Return: Vector2: cordinaterna för rutan som är vald
# Exempel:
# Datum: 3/5/2024
# Namn: Noah Westerberg
def input_square()
    input = gets.chomp
    if (input.length < 2)
        return input_square()
    end
    position = square_to_coordinets(input)
    if (position == nil)
        return input_square()
    end
    return position
end


def game()
    players = initialize_players()
    board = initialize_board()

    for player in players
        name = player.name
        enterd_name = "no"
        while enterd_name == "no"
            puts "Player #{player.color.upcase}, what is your name?"
            input_name = gets.chomp
            if input_name != ""
                name = input_name
            end
            puts "Are you sure your name is #{name}? Type \"no\" to re-enter your name"
            enterd_name = gets.chomp
        end
        player.name = name
        print "\n" * 20
    end
    
    turn = 0
    is_fliped = false

    continue_playing = true
    while continue_playing
        current_player = Player.new
        if turn % 2 == 0
            current_player = players[0]
        else
            current_player = players[1]
        end

        for row in board
            for square in row
                if (square.class == Empty)
                    next
                end
                square.find_moves(board)
            end
        end

        draw_board(board, is_fliped, [])

        selected_square = Empty.new
        avalible_positions = []
        while avalible_positions.length == 0
            selected_square = Empty.new
            while selected_square.color != current_player.color
                square_coordinets = input_square()
                selected_square = board[square_coordinets.y][square_coordinets.x]
            end
            avalible_positions = selected_square.find_moves(board)
        end

        draw_board(board, is_fliped, avalible_positions)

        move_coordinets = Vector2.new
        while !avalible_positions.include?(move_coordinets)
            move_coordinets = input_square()
        end

        selected_square.move(move_coordinets, board)

        turn += 1
        is_fliped = !is_fliped
    end
end




game()