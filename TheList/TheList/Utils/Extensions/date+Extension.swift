
import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second], from: self, to: now)

        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }

        if let year = components.year, year >= 1 {
            return "Last year"
        }

        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }

        if let month = components.month, month >= 1 {
            return "Last month"
        }

        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }

        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }

        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }

        if let day = components.day, day >= 1 {
            return "Yesterday"
        }

        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }

        if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        }

        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }

        if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        }

        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }

        return "Just now"
    }
}

