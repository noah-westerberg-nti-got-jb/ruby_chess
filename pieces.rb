Vector2 = Struct.new(:x, :y) do
    def +(vector)
        return Vector2.new(x + vector.x, y + vector.y)
    end
    def -(vector)
        return Vector2.new(x - vector.x, y - vector.y)
    end
    def *(num)
        return Vector2.new(x * num, y * num)
    end
    def /(num)
        return Vector2.new(x / num, y / num)
    end
end

# Beskrivning: Avrundar till 1, -1 eller 0
# Argument 1: Number/Int/float
# Return: Int. 1 om värdet är större än sqrt(2) / 2, -1 om värdet är minder än -sqrt(2) / 2 eller annars 0
# Exempel:
#           round_angle(0) => 0
#           round_angle(1) => 1
#           round_angle(-1) => -1
#           round_angle(0.70) => 1
#           round_angle(0.69) => 0
#           round_angle(0) => 0
# Datum: 23/4/2024
# Namn: Noah Westerberg
def round_angle(num)
    # lite marginal för att undvika gränsfall
    if num < -Math.sqrt(2) + 1.1
        return -1
    elsif num > Math.sqrt(2) - 1.1
        return 1
    else
        return 0
    end
end

# Beskrivning: Undersöker om en ruta finns på brädan och är en annan färg från pjäsen som använder funktionen och lägger till den i en input array
# Argument 1: Array, spelbrädan
# Argument 2: Vector2, positionen av rutan som ska kollas
# Argument 3: String: användar pjäsens färg
# Argument 4: Array: output array
# Return: Inget
# Exempel:
# Datum: 30/4/2024
# Namn: Noah Westerberg
def check_square(board, square_position, color, out)
    if square_position.x < board.length && square_position.y < board.length && square_position.x >= 0 && square_position.y >= 0
        check_square = board[square_position.y][square_position.x]
        check_square.set_targeted(color)
        if check_square.class == Empty
            out.append(square_position)
        elsif check_square.color != color
            out.append(square_position)
        end
    end
end

# Beskrivning: Lägger till rutor som finns i samma rad från en startposition och returnerar det.
# Argument 1: Array, spelbrädan
# Argument 2: Vector2, användarpjäsens position
# Argument 3: Vector2, hur marökern som sätter in rutorna justeras
# Argument 4: String: användar pjäsens färg
# Argument 5: Array: output-array
# Return: Inget
# Exempel:
#       Argument3/cursor_shift = (0, 0) => oändlig loop
# Datum: 4/5/2024
# Namn: Noah Westerberg
def check_squares_in_line(board, position, cursor_shift, color, out)
    x = position.x + cursor_shift.x
    y = position.y + cursor_shift.y
    while x < board.length && y < board.length && x >= 0 && y >= 0
        check_square = board[y][x]
        check_square.set_targeted(color)
        if (check_square.class != Empty)
            if (check_square.color == color)
                break
            end

            out.append(Vector2.new(x, y))
            break
        end
        
        out.append(Vector2.new(x, y))
        x += cursor_shift.x
        y += cursor_shift.y
    end
end

# Beskrivning: 
# Argument 1: Array, spelbrädan
# Argument 2: Vector2, användarpjäsens position
# Argument 3: Vector2, hur marökern som sätter in rutorna justeras
# Return: Vector2: positionen av den första pjäsen på en rad
# Exempel:
#       Argument3/cursor_shift = (0, 0) => oändlig loop
# Datum: 6/5/2024
# Namn: Noah Westerberg
def get_first_square_in_line(board, position, cursor_shift)
    first_square = nil
    x = position.x + cursor_shift.x
    y = position.y + cursor_shift.y
    while x < board.length && y < board.length && x >= 0 && y >= 0
        check_square = board[y][x]
        if (check_square.class != Empty)
            first_square = Vector2.new(x, y)
            break
        end
        x += cursor_shift.x
        y += cursor_shift.y
    end
    return first_square
end

class Piece
    attr_reader :color, :position, :icon

    # Beskrivning:
    # Argument 1:
    # Return: Bolean
    # Exempel:
    # Datum: 24/4/2024
    # Namn: Noah Westerberg
    def is_targeted(color)
        if color == "white"
            return @targeted_by_black
        else
            return @targeted_by_white
        end
    end

    # Beskrivning:
    # Argument 1:
    # Return: Inget
    # Exempel:
    # Datum: 24/4/2024
    # Namn: Noah Westerberg
    def set_targeted(color)
        if color == "white"
            @targeted_by_white = true
        else
            @targeted_by_black = true
        end
    end

    # Beskrivning: Resettar targetet fälten
    # Return: Inget
    # Exempel:
    #       Piece.remove_targeted(): <Piece @targeted_by_white=false, @targeted_by_black=false, ...>
    # Datum: 5/5/2024
    # Namn: Noah Westerberg
    def remove_targeted()
        @targeted_by_white = false
        @targeted_by_black = false
    end

    # Beskrivning: Flyttar pjäsens position. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace). Om det är viktigt för pjäsen så sparas det att den har flytat på sig
    # Argument 1: Vector2: Positionen som pjäsen ska flyta sig till.
    # Argument 2: 2D-Array: Spelbrädan
    # Return: Inget
    # Exempel:
    # Datum: 4/5/2024
    # Namn: Noah Westerberg
    def move(position, board)
        board[@position.y][@position.x] = Empty.new

        if self.class == Rook
            @has_moved = true
        end
            
        @position = position
        serialized_piece = Marshal.dump(self)
        board[position.y][position.x] = Marshal.load(serialized_piece)
    end
    
end

class Empty < Piece
    def initialize
        @icon = "#"
        @targeted_by_white = false
        @targeted_by_black = false
    end
end

class En_passant_square < Piece
    def initialize(position, color)
        @icon = "#"
        @targeted_by_white = false
        @targeted_by_black = false
        @position = position
        @color = color
        @round = 0
    end

    # Beskrivning: ökar hur många rundor som en passant rutan har funnits. Den tas bort efter att den har varit aktiv i en runda
    # Argument 1: 2D-Array: spelbrädan
    # Datum 5/5/2024
    # Namn: Noah Westerberg
    def increment_round(board)
        @round += 1
        if @round >= 2
            board[position.y][position.x] = Empty.new
        end
    end
end

class Pawn < Piece
    def initialize(position, color)
        @icon = "P"
        @color = color
        @position = position
        @has_moved = false
        @targeted_by_white = false
        @targeted_by_black = false

        if color == "white"
            @direction = 1
        else
            @direction = -1
        end
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2[]: tillgängliga positioner
    # Exempel:
    # Datum: 4/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        check_position = Vector2.new(@position.x, @position.y + @direction)
        if check_position.y < board.length && check_position.y >= 0
            check_square = board[check_position.y][check_position.x]
            if check_square.class == Empty
                positions.append(check_position)
            end
        end

        check_position = Vector2.new(@position.x - 1, @position.y + @direction)
        if check_position.x >= 0
            check_square = board[check_position.y][check_position.x]
            check_square.set_targeted(@color)
            if check_square.class != Empty
                if check_square.color != @color
                    positions.append(check_position)
                end
            end
        end

        check_position = Vector2.new(@position.x + 1, @position.y + @direction)
        if check_position.x < board.length
            check_square = board[check_position.y][check_position.x]
            check_square.set_targeted(@color)
            if check_square.class != Empty
                if check_square.color != @color
                    positions.append(check_position)
                end
            end
        end
        
        if @has_moved
            return positions
        end

        check_position = Vector2.new(@position.x, @position.y + (@direction * 2))
        check_square = board[check_position.y][check_position.x]
        if check_square.class == Empty
            positions.append(check_position)
        end

        return positions
    end

    # Beskrivning: Flyttar pjäsens position. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace). Om det är viktigt för pjäsen så sparas det att den har flytat på sig
    # Argument 1: Vector2: Positionen som pjäsen ska flyta sig till.
    # Argument 2: 2D-Array: Spelbrädan
    # Return: Inget
    # Exempel:
    # Datum: 6/5/2024
    # Namn: Noah Westerberg
    def move(position, board)
        if (position.y - @position.y).abs > 1
            en_passant_position = Vector2.new(@position.x, @position.y + ((position.y - @position.y) / 2))
            board[en_passant_position.y][en_passant_position.x] = En_passant_square.new(en_passant_position, @color)
        end
        if board[position.y][position.x].class == En_passant_square
            pawn_position = Vector2.new(@position.x + (position.x - @position.x), position.y + ((@position.y - position.y)))
            p pawn_position
            board[pawn_position.y][pawn_position.x] = Empty.new
        end

        board[@position.y][@position.x] = Empty.new
        @position = position
        @has_moved = true
        serialized_piece = Marshal.dump(self)
        board[position.y][position.x] = Marshal.load(serialized_piece)
    end
end

class King < Piece
    def initialize(position, color)
        @icon = "K"
        @color = color
        @position = position
        @has_moved = false
        @targeted_by_white = false
        @targeted_by_black = false
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2[]: tillgängliga positioner
    # Exempel:
    # Datum: 
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        angle = 0
        while angle < 2 * Math::PI
            new_position = Vector2.new(@position.x + round_angle(Math.cos(angle)), @position.y + round_angle(Math.sin(angle)))
            angle += Math::PI / 4
            check_square(board, new_position, @color, positions)
        end

        i = 0
        while i < positions.length
            if board[positions[i].y][positions[i].x].is_targeted(@color)
                positions.delete_at(i)
            else
                i += 1
            end
        end

        if @has_moved == false
            i = -1
            while i <= 1
                rook_position = get_first_square_in_line(board, @position, Vector2.new(i, 0))
                if rook_position == nil
                    i += 2
                    next
                end
                if board[rook_position.y][rook_position.x].class == Rook
                    if board[rook_position.y][rook_position.x].has_moved == false
                        targeted = false
                        j = 0
                        while j <= 2
                            if board[@position.y][@position.x + (j * i)].is_targeted(@color)
                                targeted = true
                            end
                            j += 1
                        end
                        if targeted == false
                            positions.append(Vector2.new(@position.x + (2 * i), @position.y))
                        end
                    end
                end
                i += 2
            end
        end

        return positions
    end

    # Beskrivning: Flyttar pjäsens position. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace). Om det är viktigt för pjäsen så sparas det att den har flytat på sig
    # Argument 1: Vector2: Positionen som pjäsen ska flyta sig till.
    # Argument 2: 2D-Array: Spelbrädan
    # Return: Inget
    # Exempel:
    # Datum: 6/6/2024
    # Namn: Noah Westerberg
    def move(position, board)
        if (@position.x - position.x).abs > 1
            rook_position = Vector2.new
            if (@position.x - position.x) < 0
                rook_position = Vector2.new(7, @position.y)
                p rook_position
                rook = board[rook_position.y][rook_position.x]
                p rook
                rook.move(Vector2.new(position.x - 1, position.y), board)
            else
                rook_position = Vector2.new(0, @position.y)
                p rook_position
                rook = board[rook_position.y][rook_position.x]
                p rook
                rook.move(Vector2.new(position.x + 1, position.y), board)
            end
        end
        
        board[@position.y][@position.x] = Empty.new
        @has_moved = true    
        @position = position
        serialized_piece = Marshal.dump(self)
        board[position.y][position.x] = Marshal.load(serialized_piece)
    end
end

class Queen < Piece
    def initialize(position, color)
        @icon = "Q"
        @color = color
        @position = position
        @targeted_by_white = false
        @targeted_by_black = false
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2[]: tillgängliga positioner
    # Exempel:
    # Datum: 24/4/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        
        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                if (x_dir == 0 && y_dir == 0)
                    y_dir += 1
                    next
                end
                check_squares_in_line(board, @position, Vector2.new(x_dir, y_dir), @color, positions)
                y_dir += 1
            end
            x_dir += 1
        end
        return positions
    end
end

class Knight < Piece
    def initialize(position, color)
        @icon = "Kn"
        @color = color
        @position = position
        @targeted_by_white = false
        @targeted_by_black = false
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2 Array: tillgängliga positioner
    # Exempel:
    # Datum: 2/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                check_square(board, @position + Vector2.new(2 * x_dir, 1 * y_dir), @color, positions)
                check_square(board, @position + Vector2.new(1 * x_dir, 2 * y_dir), @color, positions)
                y_dir += 2
            end
            x_dir += 2
        end

        return positions
    end
end

class Rook < Piece
    def initialize(position, color)
        @icon = "R"
        @color = color
        @position = position
        @has_moved = false
        @targeted_by_white = false
        @targeted_by_black = false
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2 Array: tillgängliga positioner
    # Exempel:
    # Datum: 2/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        check_squares_in_line(board, @position, Vector2.new(1, 0), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(-1, 0), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(0, 1), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(0, -1), @color, positions) 

        return positions
    end
end

class Bishop < Piece
    def initialize(position, color)
        @icon = "B"
        @color = color
        @position = position
        @targeted_by_white = false
        @targeted_by_black = false
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2 Array: tillgängliga positioner
    # Exempel:
    # Datum: 2/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                check_squares_in_line(board, @position, Vector2.new(x_dir, y_dir), @color, positions)
                y_dir += 2
            end
            x_dir += 2
        end

        return positions
    end
end