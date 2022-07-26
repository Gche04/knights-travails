
class Knight
    attr_accessor :location, :count, :parent, :child
    def initialize(loc)
        @location = loc
        @count = 0
        @parent = nil
        @child = nil
    end
end

class ChessBoard
    def initialize
        @Knight = nil
        @possible_moves_x = [-2, -1, 1, 2, -2, -1, 1, 2]
        @possible_moves_y = [-1, -2, -2, -1, 1, 2, 2, 1]
    end

    def knight_moves(arr1, arr2)
        moves = find_moves(arr1, arr2)
        create_knights_children(moves)

        if last_count == nil
            puts "impossible move"
        else
            puts "You made it in #{last_count} moves!  Here's your path:"
            print_loc_list 
        end
    end

    def find_moves(array1, array2)
        moves = []

        if possible?(array1[0]) && possible?(array1[1]) && possible?(array2[0]) && possible?(array1[1])
            rt = Knight.new([array1[0], array1[1]])
            arr = []
            arr << rt

            until arr.empty?
                rt_x = arr[0].location[0]
                rt_y = arr[0].location[1]

                for i in 0..7 do
                    x = rt_x + @possible_moves_y[i]
                    y = rt_y + @possible_moves_x[i]
        
                    if possible?(x) && possible?(y)
                        k = Knight.new([x, y])
                        if k.parent == nil
                            k.count = 1 + arr[0].count
                            k.parent = arr[0]
                            arr << k
                        end
                    end
                end

                first = arr.shift

                if first.location == array2
                    moves << first
                    p = first.parent

                    while p
                        moves << p
                        p = p.parent
                    end
                    return moves
                end
            end
        end
        moves
    end

    def create_knights_children(arr)
        unless arr.empty?
            arr = arr.reverse
            @Knight = arr.shift
            knt = @Knight

            until arr.empty?
                knt.child = arr.shift
                knt = knt.child
            end
        end
    end

    def last_count(rt = @Knight)
        return if rt == nil
        while rt.child
            rt = rt.child
        end
        rt.count
    end

    def print_loc_list(rt = @Knight)
        return if rt == nil
        while rt.child
            print rt.location
            puts ""
            rt = rt.child
        end
        print rt.location
        puts ""
    end

    def possible?(loc)
        return false if loc >= 8 || loc < 0
        true
    end
end

#bd = ChessBoard.new

#bd.knight_moves([7,7], [0,4])
#bd.knight_moves([0,0], [1,2])
#bd.knight_moves([3,3], [4,3])
#bd.knight_moves([8,3], [9,3])
#bd.knight_moves([5,3], [7,3])