require './test/test_helper'
include Date_Extension

class DateExtensionTest < ActiveSupport::TestCase

    test "assert correct next sunday returned" do
        dateToday =  Date.new(2019,12,12)
        nextSunday = getNextSunday(dateToday)
        expectedAnswer = Date.new(2019,12,15)
        assert_equal expectedAnswer, nextSunday
    end

    test "assert correct next saturday returned" do
        dateToday =  Date.new(2019,12,11)
        nextSaturday = getNextSaturday(dateToday)
        expectedAnswer = Date.new(2019,12,14)
        assert_equal expectedAnswer, nextSaturday
    end
    
    test "assert today is not returned if today is sunday" do
        dateToday =  Date.new(2019,12,15)
        nextSunday = getNextSunday(dateToday)
        assert_not_equal dateToday, nextSunday
    end

    test "assert today is not returned if today is saturday" do
        dateToday =  Date.new(2019,12,14)
        nextSaturday = getNextSaturday(dateToday)
        assert_not_equal dateToday, nextSaturday
    end
end