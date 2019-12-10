module Date_Extension
    def getNextSunday(dateToday)
        nextSunday = dateToday + ((7 - dateToday.wday) % 7)
        if dateToday == nextSunday
            nextSunday + 7
        else
            nextSunday
        end
        
    end
    
    def getNextSaturday(dateToday)
        nextSaturday = dateToday + ((6 - dateToday.wday) % 7)
        if dateToday == nextSaturday
            nextSaturday + 7
        else
        nextSaturday
        end
    end
end 
