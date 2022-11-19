

import Foundation

extension NSNotification.Name {
    // to update UI
    static let favorites: NSNotification.Name = NSNotification.Name(rawValue: "kFavoritesNotificationName")
    static let recommendeds: NSNotification.Name = NSNotification.Name(rawValue: "kRecommendedsNotificationName")
    
    static let downloadAdded: NSNotification.Name = NSNotification.Name(rawValue: "kDownloadAddedNotificationName")
    static let downloadProgress: NSNotification.Name = NSNotification.Name(rawValue: "kDownloadProgressNotificationName")
    static let downloadComplete: NSNotification.Name = NSNotification.Name(rawValue: "kDownloadCompleteNotificationName")
}
