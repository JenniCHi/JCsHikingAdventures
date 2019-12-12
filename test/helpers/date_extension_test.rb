require './test/test_helper'
#Need to reference the module the tested methods are in.
include Date_Extension

class DateExtensionTest < ActiveSupport::TestCase

    #As the name suggests, we test the correct next sunday is returned
    #by the getNextSunday method.
    test "assert correct next sunday returned" do
        dateToday =  Date.new(2019,12,12)
        nextSunday = getNextSunday(dateToday)
        expectedAnswer = Date.new(2019,12,15)
        assert_equal expectedAnswer, nextSunday
    end

    #As the name suggests, we test the correct next saturday is returned
    #by the getNextSaturday method.
    test "assert correct next saturday returned" do
        dateToday =  Date.new(2019,12,11)
        nextSaturday = getNextSaturday(dateToday)
        expectedAnswer = Date.new(2019,12,14)
        assert_equal expectedAnswer, nextSaturday
    end
    
    #Asserting that if today is a sunday we don't return today as the next
    #sunday.
    test "assert today is not returned if today is sunday" do
        dateToday =  Date.new(2019,12,15)
        nextSunday = getNextSunday(dateToday)
        assert_not_equal dateToday, nextSunday
    end

    #Asserting that if today is a saturday we don't return today as the next
    #saturday.
    test "assert today is not returned if today is saturday" do
        dateToday =  Date.new(2019,12,14)
        nextSaturday = getNextSaturday(dateToday)
        assert_not_equal dateToday, nextSaturday
    end
end