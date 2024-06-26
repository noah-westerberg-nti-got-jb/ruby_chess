require "rainbow"
using Rainbow

# Beskrivning: Omvandlar en position på spelbrädan till rutans betäckning
# Argument 1: Vector2 - positionen som ska omvandlas
# Return: 
#       String - Rutans betäckning
#       nil - ogiltig inmatning
# Exempel:
#       position_to_square_name(Vector2.new(0, 0)) => a1
#       position_to_square_name(Vector2.new(7, 7)) => h8
#       position_to_square_name(Vector2.new(3, 3)) => d4
#       position_to_square_name(Vector2.new(5, 7)) => f8
#       position_to_square_name(Vector2.new(-1, 4)) => nil
#       position_to_square_name(Vector2.new(3, 15)) => nil
# Datum: 5/5/2024
# Namn: Noah Westerberg
def position_to_square_name(position)
    column = ""
    if position.x == 0
        column += "a"
    elsif position.x == 1
        column += "b"
    elsif position.x == 2
        column += "c"
    elsif position.x == 3
        column += "d"
    elsif position.x == 4
        column += "e"
    elsif position.x == 5
        column += "f"
    elsif position.x == 6
        column += "g"
    elsif position.x == 7
        column += "h"
    else
        return nil
    end
    
    if position.y >= 0 && position.y < 8
        return "#{column}#{position.y + 1}"
    end
end

# Beskrivning: Ritar ut spelbrädan
# Argument 1: Array - spelbrädan
# Argument 2: Boolean - om brädan ska vara omvänd
# Argument 3: Array - positioner på rutor som ska vara markerade
# Datum: 6/5/2024
# Namn: Noah Westerberg
def draw_board(board, fliped, highlighted_squares)
    if fliped
        print "  H|G|F|E|D|C|B|A\n"
        i = 0
        loop_end_value = board.length
    else
        print "  A|B|C|D|E|F|G|H\n"
        i = board.length - 1
        loop_end_value = -1
    end
    # looparna går fram-/baklänges beroende på om brädan ska vara vänd eller inte
    while i != loop_end_value
        print "#{i+1}|"
        j = 0
        if fliped
            j = board.length - 1
        end
        while j != 7 - loop_end_value
            current_square = board[i][j]
            square_text = current_square.icon
            if board[i][j].class != Knight
                square_text += " "
            end
            
            if board[i][j].class == Empty || board[i][j].class == En_passant_square
                square_text = Rainbow(square_text).hide
            elsif board[i][j].color == "white"
                square_text = Rainbow(square_text).lightblue
            else
                square_text = Rainbow(square_text).black
            end

            if (j + i) % 2 == 0
                square_text = Rainbow(square_text).bg(:brown)
            else
                square_text = Rainbow(square_text).bg(:burlywood)
            end

            if highlighted_squares.include?(Vector2.new(j, i))
                if board[i][j].class == Empty || board[i][j].class == En_passant_square
                    square_text = position_to_square_name(Vector2.new(j, i))
                    square_text = Rainbow(square_text).bg(:blue).bisque
                    if board[i][j].class == En_passant_square
                        square_text = Rainbow(square_text).red
                    end
                else
                    square_text = Rainbow(square_text).bg(:blue).red
                end
            end
                
            print square_text
            
            if fliped
                j -= 1
            else
            j += 1
            end
        end
        print "|#{i+1}\n"
        if fliped
            i += 1
        else
            i -= 1
        end
    end
    if fliped
        print "  H|G|F|E|D|C|B|A\n"
    else
        print "  A|B|C|D|E|F|G|H\n"
    end
end