//
//  ExtendDate.swift
//  SevenFuns
//
//  Created by Apprentice on 11/18/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import Foundation

extension String {

  func toNSDate() -> NSDate {
    guard let date = NSDate.dateFromRFC3339FormattedString(self) else {
      return NSDate()
    }
    return date
  }

}


extension NSDate {

  var stringFormattedAsRFC3339: String {
    return rfc3339formatter.stringFromDate(self)
  }

  class func dateFromRFC3339FormattedString(rfc3339FormattedString:String) -> NSDate?
  {
    /*
    NOTE: will replace this with a failible initializer when Apple fixes the bug
    that requires the initializer to initialize all stored properties before returning nil,
    even when this is impossible.
    */
    if let d = rfc3339formatter.dateFromString(rfc3339FormattedString)
    {
      return NSDate(timeInterval:0,sinceDate:d)
    }
    else {
      return nil
    }
  }
}

private var rfc3339formatter:NSDateFormatter = {
  let formatter = NSDateFormatter()
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
  formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
  formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
  formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
  return formatter
}()


extension NSDate {

  func yearsFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
  }

  func monthsFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
  }

  func weeksFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
  }

  func daysFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
  }

  func hoursFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
  }

  func minutesFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
  }

  func secondsFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
  }

  func offsetFrom(date:NSDate) -> String {
    if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
    if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
    if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
    if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
    if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
    if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
    if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
    return ""
  }

  func getOffsetStringFrom(date: NSDate) -> String {
    if yearsFrom(date)   > 0 { return "\(yearsFrom(date))年前"   }
    if monthsFrom(date)  > 0 { return "\(monthsFrom(date))個月前"  }
    if weeksFrom(date)   > 0 { return "\(weeksFrom(date))週前"   }
    if daysFrom(date)    > 0 { return "\(daysFrom(date))天前"    }
    if hoursFrom(date)   > 0 { return "\(hoursFrom(date))小時前"   }
    if minutesFrom(date) > 0 { return "\(minutesFrom(date))分鐘前" }
    if secondsFrom(date) > 0 { return "\(secondsFrom(date))秒前" }
    return "0秒前"
  }

}


func <=(lhs: NSDate, rhs: NSDate) -> Bool {
  let res = lhs.compare(rhs)
  return res == .OrderedAscending || res == .OrderedSame
}
func >=(lhs: NSDate, rhs: NSDate) -> Bool {
  let res = lhs.compare(rhs)
  return res == .OrderedDescending || res == .OrderedSame
}
func >(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedDescending
}
func <(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedAscending
}
func ==(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedSame
}