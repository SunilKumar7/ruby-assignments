#Creation of simple excel in ruby.
#options 1 - SET VALUE, 2 - SET EXPRESSION

class SimpleExcel 
	attr_accessor :array, :expressions, :stack
	#Creation of array.
	def initialize(r,c)
		@array = Array.new(r) { Array.new(c) }
		@expressions = Hash.new
		@stack = []
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
		puts "1 - Set Value" 
		puts "2 - Set Expression"
		puts "3 - Exit the program"
		puts "Enter your choice: "
	end

	def getValue(gridExp)
		row = gridExp[0].upcase.ord - 'A'.ord 
		col = gridExp[1..-1].to_i
		return @array[row][col]
	end

	def evaluatePostFixExpression(postfix)
		stack = []
		postfix.each do | value |
			case value
			when "+"
				stack << stack.pop.to_i + stack.pop.to_i
			when "-"
				stack <<  stack.pop.to_i - stack.pop.to_i
			when "*"
				stack <<  stack.pop.to_i * stack.pop.to_i
			when "/"
				stack <<  stack.pop.to_i / stack.pop.to_i
			when "**"
				stack <<  stack.pop.to_i ** stack.pop.to_i
			else
				stack <<  getValue(value).to_i
			end 
		end 
		return stack[stack.length - 1]
	end

	def updateExcel()
		returnValue = false
		if expressions.empty? 
			return returnValue
		else
			expressions.each do | key, value |
				expData = value.split("=")
				currentData = getValue(expData[0])
				cellsValues = expData[1].split(" ")
				postfixData = convertToPostFix(cellsValues)
				row = expData[0][0].upcase.ord - 'A'.ord
				col = expData[0][1..-1].to_i
				@array[row][col] = evaluatePostFixExpression(postfixData)
				if currentData != array[row][col]
					returnValue = true
				end
			end
			return returnValue
		end
	end

	def getPrecendence(operator)
		if operator == "**"	
			return 3
		elsif operator == "*" or operator == "/"
			return 2
		else
			return 1
		end
	end

	def convertToPostFix(cellsValues)
		postfix = []
		index = 0
		cellsValues.each do | value |
		if value == "+" or value == "-" or value == "*" or value == "/" or value == "**"
			if(stack.size != 0 and (getPrecendence(value) > getPrecendence(stack[-1])))
				postfix[index] = stack.pop
				@stack[@stack.length] = value
				index += 1
			else
				@stack[@stack.length] = value
			end
		else
			postfix[index] = value
			index += 1
		end
		end
		if(stack.size != 0)
			while(stack.size != 0)
				postfix[index] = stack.pop
				index += 1
			end
		end
		return postfix
	end

	#Function when Set Expression option is selected
	def setExpression(expression)
		expValue = expression.split("=")
		destinationCell = expValue[0]
		cellsValues = expValue[1].split(" ")
		postfixData = convertToPostFix(cellsValues)
		row = destinationCell[0].upcase.ord - 'A'.ord
		col = destinationCell[1..-1].to_i
		@array[row][col] = evaluatePostFixExpression(postfixData)
		expressions[destinationCell] = expression
		while(updateExcel())
		end
	end

	#Function when Set Value option is selected 
	def setValue(value)
		valueArray = value.split("=")
		row = valueArray[0][0].upcase.ord - 'A'.ord
		col = valueArray[0][1..-1].to_i 
		if row >= 10 or col >= 10
			puts "Grid value exceeded"
			return
		end
		@array[row][col] = valueArray[1]
		while(updateExcel())
		end
	end

end

class Main
	def self.start(rows, cols)
		puts "Welcome, Choose any of the functions"
		simpleexcel = SimpleExcel.new(rows, cols)
		while(true)
			simpleexcel.printMenu
			input = STDIN.gets.chomp
			case input
				when "1"
					puts "Enter the value{Format <SourceCell> = <Value>}"
					value = STDIN.gets.chomp
					simpleexcel.setValue(value)
					simpleexcel.printArray
				when "2"
					puts "Enter Expression{Format  <DestinationCell> = [<Cell1> <Operator> <Cell2> ]*}"
					expression = STDIN.gets.chomp
					simpleexcel.setExpression(expression)
					simpleexcel.printArray
				when "3"
					break
				else
					puts "Wrong Input, Try Again"
			end
		end		
		puts "Thank You, Bye"
	end
end

#RUN THE PROGRAM
Main.start(ARGV[0].to_i, ARGV[1].to_i)