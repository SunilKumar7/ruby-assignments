#Program to calculate the average of positive numbers present in an alphanumeric string.
#Input  : String
#Output : Number

class Main
	attr_accessor :str
	
	def initialize(inp)
		@str = inp
	end

	#Function to calculate the avergae of the positive numbers
	def calculateAverage()
		len = str.length
		index = 0
		finalValue = 0
		divisor = 0.0
		while index < len
			value = ""
			#If it is a negative number, just iterate over the number
			if str[index] == '-'
				iteration = 0
				index += 1
				if str[index] >= '0' && str[index] <= '9'
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
				divisor += 1
				while index < len && str[index] >= '0' && str[index] <= '9'
					value[iteration] = str[index] 
					index += 1
					iteration += 1
				end
				if value == "0"
					divisor -= 1
				end
				finalValue += value.to_i 
			#else just increment the value if its not a number at all.
			else
				index += 1
			end	
		end
		#If there are no positive numbers, then return 0 else return finalValue/divisor
		return  divisor != 0 ? finalValue / divisor : 0 
	end
end

#Take input for the program
print "Enter your input String: "
data = gets.chomp
mainProgram = Main.new(data)
puts mainProgram.calculateAverage
