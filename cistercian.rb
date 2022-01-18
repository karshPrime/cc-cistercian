#!/usr/bin/env ruby
require 'gosu'

def input_number()
    print ">>> "
    user_number = gets.chomp.to_i
    if (0...10000).include?(user_number)
        return user_number.to_s
    else
        puts "enter a valid positive number <= 9999"
        input_number()
    end
end

def draw_info(position)
    cords = [0, 0]
    direction = [1, 1]
    
    if position % 2 == 0     # left right
        cords[0] = 20
    else 
        cords[0] = 80
        direction[0] = -1
    end

    if position < 2         # up down
        cords[1] = 170
        direction[1] = -1
    else 
        cords[1] = 30
    end

    return cords, direction
end

def one(cords, direction)
    draw_line(cords[0], cords[1], 0xff_fd4646, (cords[0]+(direction[0] * 30)),
    cords[1], 0xff_fd4646, 1)
end

def two(cords, direction)
    draw_line(cords[0], (cords[1] + (direction[1] * 30)), 0xff_fd4646,
    (cords[0]+(direction[0] * 30)), (cords[1] + (direction[1] * 30)), 0xff_fd4646, 1)    
end

def three(cords, direction)
    draw_line((cords[0] + (direction[0] * 30)), cords[1], 0xff_fd4646,
    cords[0], (cords[1] + (direction[1] * 30)), 0xff_fd4646, 1)
end

def four(cords, direction)
    draw_line(cords[0], cords[1], 0xff_fd4646,
    (cords[0] + (direction[0] * 30)), (cords[1] + (direction[1] * 30)), 0xff_fd4646, 1)
end

def six(cords, direction)
    draw_line(cords[0], cords[1], 0xff_fd4646,
    cords[0], (cords[1] + (direction[1] * 30)), 0xff_fd4646, 1)
end

def draw_cistercian(number)
    for i in 0...number.size()
        cords, direction = draw_info(i)
        case number[i]
        when "1"
            one(cords, direction)
        when "2"
            two(cords, direction)
        when "3"
            three(cords, direction)
        when "4"
            four(cords, direction)
        when "5"
            one(cords, direction)
            four(cords, direction)
        when "6"
            six(cords, direction)
        when "7"
            one(cords, direction)
            six(cords, direction)
        when "8"
            two(cords, direction)
            six(cords, direction)
        when "9"
            one(cords, direction)
            two(cords, direction)
            six(cords, direction)
        end
    end
end

class CistercianDrawer < Gosu::Window
    def initialize()
        super 100, 200, false
        @decimal_number = input_number()
        while @decimal_number.size < 4
            @decimal_number = "0" + @decimal_number
        end
    end

    def draw()
    Gosu.draw_rect(0, 0, 100, 200, 0xff_121212, 0)
    draw_line(50, 30, 0xff_fd4646, 50, 170, 0xff_fd4646, 0)
    draw_cistercian(@decimal_number)
    end

    def button_down(id)
        close if id == Gosu::KB_ESCAPE
    end
end

CistercianDrawer.new.show()
