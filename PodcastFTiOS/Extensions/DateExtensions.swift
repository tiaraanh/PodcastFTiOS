
import Foundation

extension Date {
    func formatIso(input: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formatterDate = formatter.date(from: input)
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        let formatterString = formatter.string(from: formatterDate!)
        return formatterString
    }
    
    func dateFormatter(format: String, input: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: input)
        
        return date!
    }
    
    func stringDateFormatter(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "en_US_POSIX")

        return formatter.string(from: self)
    }
    
    func convertDateFormat(inputDate: String) -> String {
         let lastDateFormatter = DateFormatter()
        lastDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

         let lastDate = lastDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
        

         return convertDateFormatter.string(from: lastDate!)
    }
    
}
 
