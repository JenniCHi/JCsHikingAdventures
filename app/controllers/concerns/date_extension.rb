module Date_Extension
    #This method gets the next Sunday based on today's date.
    #If today is Sunday already, it returns next week's Sunday
    def getNextSunday(dateToday)
        nextSunday = dateToday + ((7 - dateToday.wday) % 7)
        if dateToday == nextSunday
            nextSunday + 7
        else
            nextSunday
        end
        
    end
    
    #This method gets the next Saturday based on today's date.
    #If today is Saturday already, it returns next week's Saturday
    def getNextSaturday(dateToday)
        nextSaturday = dateToday + ((6 - dateToday.wday) % 7)
        if dateToday == nextSaturday
            nextSaturday + 7
        else
        nextSaturday
        end
    end
end 
