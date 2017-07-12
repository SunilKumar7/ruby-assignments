#Creation of simple excel in ruby.
#options 1 - SET VALUE, 2 - SET EXPRESSION

class MovieBookingSystem
  attr_accessor :array, :filled, :tickets
  #Creation of array.
  def initialize(r, c)
    @array = Array.new(r.to_i) {Array.new(c.to_i)}
    @tickets = r.to_i * c.to_i
    @filled = 0
  end

  #Function to print thr Excel sheet
  def printArray()
    index = 0
    print "-------"
    (0...array[0].length).each do |row|
      print "------"
    end
    puts ""
    print "|  -  "
    characters = 65
    (0...array[0].length).each do |row|
        print "|  #{characters.chr}  "
        characters += 1
    end
    puts "|"
    for rows in array
      print "-------"
      for value in rows
        print "------"
      end
      puts ""
      print "|  #{index}  |"
      index += 1
      for value in rows
        print "  #{value.to_i}  |"
      end
      puts ""
    end
    print "-------"
    (0...array[0].length).each do |row|
      print "------"
    end
    puts ""
  end

  #Printing an array
  def printMenu()
    puts "Select Any option from the menu"
    puts "1 - Show Grid"
    puts "2 - Book Ticket(s)"
    puts "3 - Cancel Ticket(s)"
    puts "4 - Exit the program"
    puts "Enter your choice: "
  end

  def getValue(gridExp)
    row = gridExp[0].upcase.ord - 'A'.ord
    col = gridExp[1..-1].to_i
    return @array[row][col]
  end

  def checkAvailability(ticketCount)
    if (filled.to_i + ticketCount.to_i) > tickets.to_i
      puts "Sorry, no sufficient tickets"
      return -1
    else
      @filled += ticketCount.to_i
      puts "There is availability of tickets"
      return 1
    end
  end

  def checkSeatAvailability(seatNumber)
    row = seatNumber[0].upcase.ord - 'A'.ord
    col = seatNumber[1..-1].to_i
    if array[row][col].to_i == 0
      return true
    else
      return false
    end
  end

  def cancelTickets(seats)
    seats.each do |seat|
      row = seat[0].upcase.ord - 'A'.ord
      col = seat[1..-1].to_i
      @array[row][col] = 0
    end
  end

  def bookTickets(seats)
    seats.each do |seat|
      row = seat[0].upcase.ord - 'A'.ord
      col = seat[1..-1].to_i
      @array[row][col] = 1
    end
  end
end


  class Main
    def self.start(row, col)
      puts "Welcome, Choose any of the functions"
      movieBookingSystem = MovieBookingSystem.new(row, col)
      while (true)
        movieBookingSystem.printMenu
        input = STDIN.gets.chomp
        case input
          when "1"
            system("clear")
            movieBookingSystem.printArray
          when "2"
            puts "Enter number of tickets you want to book: "
            ticketCount = Integer(STDIN.gets) rescue false
            system("clear")
            if ticketCount
              if movieBookingSystem.checkAvailability(ticketCount) == 1
                puts "Enter the row/column number to book your seat {Format [A-Z][0-9]}\nEnter Q/q to quit anytime."
                print "Enter: "
                seatNumbers = []
                (0...ticketCount.to_i).each do |index|
                  seatNumbers[index] = STDIN.gets.chomp
                  if seatNumbers[index] == 'Q' || seatNumbers[index] == 'q'
                    break
                  else
                    if !movieBookingSystem.checkSeatAvailability(seatNumbers[index])
                      puts "Sorry, this seat is booked. Please Enter another seat number"
                    end
                  end
                end
                if seatNumbers.include?("Q") || seatNumbers.include?("q")
                  system("clear")
                  puts "Tickets are not booked, try again later."
                else
                  movieBookingSystem.bookTickets(seatNumbers)
                  system("clear")
                  puts "Tickets are successfully booked"
                end
              else
                puts "Please check the availability of number of tickets again"
              end
            else
              puts "Enter only numbers"
            end
          when "3"
            puts "Enter number of tickets you want to cancel: "
            ticketCount = Integer(STDIN.gets) rescue false
            system("clear")
            if ticketCount
              if movieBookingSystem.checkAvailability(ticketCount) == 1
                puts "Enter the row/column number to cancel your seat {Format [A-Z][0-9]}\nEnter Q/q to quit anytime."
                print "Enter: "
                seatNumbers = []
                (0...ticketCount.to_i).each do |index|
                  seatNumbers[index] = STDIN.gets.chomp
                  if seatNumbers[index] == 'Q' || seatNumbers[index] == 'q'
                    break
                  else
                    if movieBookingSystem.checkSeatAvailability(seatNumbers[index])
                      puts "Sorry, this seat is not booked. Please Enter another seat number to cancel"
                    end
                  end
                end
                if seatNumbers.include?("Q") || seatNumbers.include?("q")
                  system("clear")
                  puts "Tickets are not cancelled, try again later."
                else
                  movieBookingSystem.cancelTickets(seatNumbers)
                  system("clear")
                  puts "Tickets are successfully cancelled"
                end
              else
                puts "Please check the number of tickets to cancel again"
              end
            else
              puts "Enter only numbers"
            end
          when "4"
            break
          else
            puts "Wrong Input, Try Again"
        end
      end
    puts "Thank You, Bye"
    end
  end


  #RUN THE PROGRAM
  Main.start(ARGV[0], ARGV[1])