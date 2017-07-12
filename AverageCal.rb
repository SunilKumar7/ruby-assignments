#Program to calculate the average of positive numbers present in an alphanumeric string.
#Input  : String
#Output : Number

class Main
	attr_accessor :str, :negativeNum, :divisor
	
	def initialize(inp)
		self.str = inp
		self.negativeNum = 0
		self.divisor = 0.0
	end

	#Function to calculate the avergae of the positive numbers
	def calculateAverage()
		len = str.length
		index = 0
		finalValue = 0
		charCount = 0
		while index < len
			value = ""
			#If it is a negative number, just iterate over the number
			if str[index] == '-'
				iteration = 0
				index += 1
				if str[index] > '0' && str[index] <= '9'
					@negativeNum += 1
					while index < len && str[index] >= '0' && str[index] <= '9'
						index += 1
					end
				else
					index += 1
				end
			#If it is a positive number, then calculate the value of the number and add it to the final value
			# Also, if it is 0, we need to subtract the divisor by 1 since it's not a positive number
			# else, we increment the divisor value
			elsif str[index] >= '0' && str[index] <= '9'
				iteration = 0
				divisor = divisor.to_f + 1
				while index < len && str[index] >= '0' && str[index] <= '9'
					value[iteration] = str[index] 
					index += 1
					iteration += 1
				end
				if value == "0"
					divisor = divisor.to_f - 1
				end
				finalValue += value.to_i 
			#else just increment the value if its not a number at all.
			else
				charCount = 1
				index += 1
			end	
		end
		if negativeNum > 0 && divisor.to_f == 0.0 && charCount == 0
			return -1
		elsif negativeNum == 0 && divisor.to_i == 0
			return -2
		elsif charCount == 1
			return -3
		else
			return  divisor.to_f != 0 ? finalValue / divisor.to_f : 0 
		end
	end
end

#Take input for the program
print "Enter your input String: "
begin
	data = gets.chomp
	mainProgram = Main.new(data)
	if data.length == 0
		raise "String contain no +ve number"
	else
		result = mainProgram.calculateAverage
		if result == -1
			raise "String contains all negative numbers."
		elsif result == -2
			raise "String contains all characters or special characters."
		elsif result == -3
			raise "String contain no +ve number."
		else
			puts data
		end
	end
	rescue Exception => err
		puts err.message
end
				
		