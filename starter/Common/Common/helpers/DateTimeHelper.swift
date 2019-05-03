//
//  DateHelper.swift
//  Footkal
//
//  Created by Remote User on 5/8/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation


struct DateTimeHelper {
    public static func date(from string:String,format:String="dd-MM-yyyy",localeIdentifier:String="en_US")->Date?{
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat=format
        dateFormatter.locale=Locale(identifier: localeIdentifier)
   
        return dateFormatter.date(from: string)
    }
    
}


extension Date{
   public func toString(format:String="dd-MM-yyyy",localeIdentifier:String="en_US")->String{
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat=format
        dateFormatter.locale=Locale(identifier: localeIdentifier)
        
        return dateFormatter.string(from: self)
    }
    
    public func toString(format:String="dd-MM-yyyy",identifier:Calendar.Identifier)->String{
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: identifier)
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
   public func toPersianDate(format:String="yyyy/MM/dd")->String{
        return toString(format: format, identifier: .persian)
    }
    
   public func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: component, value: value, to: self)!
    }
}



//MARK:- pretty time format
extension Date{
    /**
     Formats a date as the time since that date (e.g., “Last week, yesterday, etc.”).
     
     - Parameter from: The date to process.
     - Parameter numericDates: Determines if we should return a numeric variant, e.g. "1 month ago" vs. "Last month".
     
     - Returns: A string with formatted `date`.
     */
    func prettyTime() -> String {
        let calendar = Calendar.current
        let from=self
        let now = NSDate()
        let earliest = now.earlierDate(from as Date)
        let latest = earliest == now as Date ? self : now as Date
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)

        var result = ""

//        if components.year! >= 2 {
//            result = R.string.localizable.yearAgo(components.year!)
//        } else if components.year! == 1 {\()
//                result = R.string.localizable.lastYear()
//        } else if components.month! >= 2 {
//            result = R.string.localizable.monthAgo(components.month!)
//        } else if components.month! == 1 {
//            result = R.string.localizable.lastMonth()
//        } else if components.weekOfYear! >= 2 {
//            result = R.string.localizable.weekAgo(components.weekOfYear!)
//        } else if components.weekOfYear! == 1 {
//            result = R.string.localizable.lastWeek()
//        } else if components.day! >= 2 {
//           result = R.string.localizable.dayAgo(components.day!)
//        } else if components.day! == 1 {
//            result = R.string.localizable.yesterday()
//        } else if components.hour! >= 2 {
//            result = R.string.localizable.hourAgo(components.hour!)
//        }  else if components.hour! == 1 {
//           result = R.string.localizable.anHourAgo()
//        } else if components.minute! >= 2 {
//            result = R.string.localizable.minAgo(components.minute!)
//        }  else if components.minute! == 1 {
//            result = R.string.localizable.aMinAgo()
//        }  else if components.second! >= 5 {
//            result = R.string.localizable.momentsAgo()
//        } else {
//            result = R.string.localizable.justNow()
//        }
//        
        return result

    }
}

//MARK:- offset
extension Date {
    /// Returns the amount of years from another date
   public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
   public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
   public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
   public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
   public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
  public  func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
   public func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}


//MARK:- Formatting
extension String
{
    /**
     Extends `String` to provide a function for parsing the receiver
     as an [RFC 1123](https://www.ietf.org/rfc/rfc1123.txt) date.
     
     - returns: A `Date` parsed from the receiver, or `nil` if the
     receiver did not contain a date string in the expected format.
     */
    public func asDateRFC1123()
        -> Date?
    {
        return Date.Formatter.rfc1123.date(from: self)
    }
    
    /**
     Extends `String` to provide a function for parsing the receiver
     as an [ISO 8601](http://www.w3.org/TR/NOTE-datetime) date.
     - returns: A `Date` parsed from the receiver, or `nil` if the
     receiver did not contain a date string in the expected format.
     */
    public func asDateISO8601()
        -> Date?
    {
        /** Chain of parsers solves the issue when services use different
         date formats with millisonds of even without time */
        
        if let date = Date.Formatter.iso8601DateTimeMillis.date(from: self) {
            return date
        }
        if let date = Date.Formatter.iso8601DateTime.date(from: self) {
            return date
        }
        if let date = Date.Formatter.iso8601Date.date(from: self) {
            return date
        }
        return nil
    }
}


public enum StandardDateFormat: String
{
    /** The date format string representing an
     [RFC 1123](https://www.ietf.org/rfc/rfc1123.txt) date. */
    case rfc1123 = "EEE, dd MMM yyyy HH:mm:ss z"
    
    /** The date format strings representing an
     [ISO 8601](http://www.w3.org/TR/NOTE-datetime) date. */
    case iso8601Date = "yyyy-MM-dd"
    case iso8601DateTime = "yyyy-MM-dd'T'HH:mm:ssZ"
    case iso8601DateTimeMillis = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}


extension Date {
    public struct Formatter {
        
        //MARK: Fixed-format dates
        /**
         If using NSDateFormatter to parse date strings to be exchanged with a
         web service (or stored in a database), you should use en_US_POSIX locale
         to avoid problems with international users who might not be using
         Gregorian calendars. See Apple Technical Q&A #1480.
         https://developer.apple.com/library/content/qa/qa1480/_index.html
         */
        private static func fixedDateFormatter(format: StandardDateFormat) -> DateFormatter {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = format.rawValue
            return formatter
        }
        
        public static let iso8601Date: DateFormatter = {
            return fixedDateFormatter(format: .iso8601Date)
        }()
        
        public static let iso8601DateTime: DateFormatter = {
            return fixedDateFormatter(format: .iso8601DateTime)
        }()
        
        public static let iso8601DateTimeMillis: DateFormatter = {
            return fixedDateFormatter(format: .iso8601DateTimeMillis)
        }()
        
        public static let rfc1123: DateFormatter = {
            return fixedDateFormatter(format: .rfc1123)
        }()
    }
}




public extension Date
{
    /**
     `true` if the receiver represents a time in the past; `false` otherwise.
     */
    var isPast: Bool {
        return timeIntervalSinceNow < 0
    }
    
    
    /**
     `true` if the receiver represents a time in the past; `false` otherwise.
     */
    var notPast: Bool {
        return !isPast
    }
    
    /**
     `true` if the receiver represents the current time; `false` otherwise.
     */
    var isNow: Bool {
        return timeIntervalSinceNow == 0
    }
    
    /**
     `true` if the receiver represents a time in the future; `false` otherwise.
     */
    var isFuture: Bool {
        return timeIntervalSinceNow > 0
    }
    
    /**
     `true` if the receiver represents any time yesterday; `false` otherwise.
     */
    var isYesterday: Bool {
        let yest = Date.yesterday
        return isBetween(yest.startOfDay, and: yest.endOfDay)
    }
    
    /**
     `true` if the receiver represents any time today; `false` otherwise.
     */
    var isToday: Bool {
        let now = Date()
        return isBetween(now.startOfDay, and: now.endOfDay)
    }
    
    /**
     `true` if the receiver represents any time tomorrow; `false` otherwise.
     */
    var isTomorrow: Bool {
        let yest = Date.tomorrow
        return isBetween(yest.startOfDay, and: yest.endOfDay)
    }
    
    /**
     `true` if the receiver represents any time nextweek today; `false` otherwise.
     */
    var isNextWeek: Bool {
        let nextWeek = Date.nextWeek
        return isBetween(nextWeek.startOfDay, and: nextWeek.endOfDay)
    }
    
    /**
     `true` if the receiver represents any time before today; `false` otherwise.
     */
    var isBeforeToday: Bool {
        return self < Date().startOfDay
    }
    
    /**
     `true` if the receiver represents any time after today; `false` otherwise.
     */
    var isAfterToday: Bool {
        return self > Date().endOfDay
    }
    
    /**
     Determines if the receiver represents a time between two given times
     or is equal to one of the times.
     **Note:** The order of the `time1` and `time2` arguments is not
     significant; they may be swapped without changing the return value of
     the function.
     - parameter time1: The first `Date` value.
     - parameter time2: The second `Date` value.
     - returns: `true` if the receiver represents any time between `time1` and
     `time2` (inclusive); `false` otherwise.
     */
    func isBetween(_ time1: Date, and time2: Date)
        -> Bool
    {
        let earlierTime = time1 < time2 ? time1 : time2
        let laterTime = time1 > time2 ? time1 : time2
        
        return (self >= earlierTime) && (self <= laterTime)
    }
    
    /**
     Determines if the current time falls between two given times or is equal
     to one of the times.
     **Note:** The order of the `time1` and `time2` arguments is not
     significant; they may be swapped without changing the return value of
     the function.
     - parameter time1: The first `Date` value.
     - parameter time2: The second `Date` value.
     - returns: `true` if the current time is between `time1` and `time2`
     (inclusive); `false` otherwise.
     */
    static func currentTimeIsBetween(_ time1: Date, and time2: Date)
        -> Bool
    {
        return Date().isBetween(time1, and: time2)
    }
    
    /**
     Determines whether the specified `Date` represents the same day as the
     receiver.
     - parameter date: The date to test.
     - returns: `true` if `date` represents any time on the same day as the
     receiver; `false` otherwise.
     */
    func isSameDayAs(_ date: Date)
        -> Bool
    {
        return isBetween(date.startOfDay, and: date.endOfDay)
    }
}





//MARK:- DateManipulation
public extension Date
{
    /**
     Returns a new `Date` set to the same day as the receiver but with a time
     changed to the specified hour, minute, second and nanosecond.
     - parameter hour: The hour component for the returned time.
     - parameter minute: The minute component for the returned time.
     - parameter second: The second component for the returned time.
     - parameter nanosecond: The nanosecond component for the returned time.
     - returns: The new `Date` with the time changed.
     */
    func changedTime(hour: Int, minute: Int, second: Int, nanosecond: Int)
        -> Date
    {
        let calendar = Calendar.current
        var dayStart = calendar.dateComponents([.day, .month, .year, .timeZone], from: self)
        dayStart.hour = hour
        dayStart.minute = minute
        dayStart.second = second
        dayStart.nanosecond = nanosecond
        
        return calendar.date(from: dayStart)!
    }
    
    /**
     Returns a new `Date` representing the 24-hour time `00:00:00` on the
     same day as the receiver.
     */
    var startOfDay: Date {
        return changedTime(hour: 0, minute: 0, second: 0, nanosecond: 0)
    }
    
    /**
     Returns a new `Date` representing the 24-hour time `23:59:59.999999999`
     on the same day as the receiver.
     */
    var endOfDay: Date {
        return changedTime(hour: 23, minute: 59, second: 59, nanosecond: 999_999_999)
    }
    
    /**
     Returns a new `Date` representing the current time, but with yesterday's
     date.
     */
    static var yesterday: Date {
        return Date().dayBefore
    }
    
    /**
     Returns a new `Date` representing the current time, but with tomorrow's
     date.
     */
    static var tomorrow: Date {
        return Date().dayAfter
    }
    
    /**
     Returns a new `Date` representing the current time, but with tomorrow's
     date.
     */
    static var nextWeek: Date {
        return Date().add(component: .day, value: 7)
    }
    
    /**
     Returns a new `Date` containing the same time as the receiver, but with
     the date adjusted earlier or later by the given number of days.
     - parameter days: The number of days to add to (if positive) or subtract
     from (if negative) the receiver.
     - returns: The new `Date` instance.
     */
    func adjustDay(_ days: Int)
        -> Date
    {
        return Calendar.current.date(byAdding: .day, value: days, to: self, wrappingComponents: true)!
    }
    
    /**
     Returns a new `Date` containing the same time as the receiver, but one
     day earlier.
     - returns: The new `Date` instance.
     */
    var dayBefore: Date {
        return adjustDay(-1)
    }
    
    /**
     Returns a new `Date` containing the same time as the receiver, but one
     day later.
     - returns: The new `Date` instance.
     */
    var dayAfter: Date {
        return adjustDay(1)
    }
}




//MARK:- Time Ago
extension Date{
   public var timeAgo:String{
        return TimeAgo.timeAgo(date: self)
    }
}



struct TimeAgo {
    
   public static func timeAgo(date: Date)-> String {
        return timeAgo(timeInterval: date.timeIntervalSince1970)
    }
    
    public static func timeAgo(timeInterval: TimeInterval)-> String {
        let diff = Date().timeIntervalSince1970 - timeInterval
        
        let prefix = "time_ago_prefix".localized()
        let suffix = "time_ago_suffix".localized()
        
        let seconds = (abs(diff))
        let minutes = seconds / 60
        let hours = minutes / 60
        let days = hours / 24
        let years = days / 365
        
        let words: String
        
        if (seconds < 10) {
            words = "time_ago_moment".localized()
        }
        else if (seconds < 45) {
            words = "time_ago_seconds".localized()
        } else if (seconds < 90) {
            words = "time_ago_minute".localized()
        } else if (minutes < 45) {
            words = "time_ago_minutes".localized(arguments: Int(round(minutes)))
        } else if (minutes < 90) {
            words = "time_ago_hour".localized()
        } else if (hours < 24) {
            words = "time_ago_hours".localized(arguments: Int(round(hours)))
        } else if (hours < 42) {
            words = "time_ago_day".localized()
        } else if (days < 30) {
            words = "time_ago_days".localized(arguments: Int(round(days)))
        } else if (days < 45) {
            words = "time_ago_month".localized()
        } else if (days < 365) {
            words = "time_ago_months".localized(arguments: Int(round(days / 30)))
        } else if (years < 1.5) {
            words = "time_ago_year".localized()
        } else {
            words = "time_ago_years".localized(arguments:  Int(round(years)))
        }
        
        var sb = ""
        
        if (prefix.isNotEmpty) {
            sb += "\(prefix) "
        }
        
        sb += words
        
        if (suffix.isNotEmpty) {
            sb += " \(suffix)"
        }
        
        return sb
    }
}
