//
//  FeedCachePolicy.swift
//  EssentialFeed
//

import Foundation

internal final class FeedCachePolicy {
    private init() {}
    
    static private let calender = Calendar(identifier: .gregorian)
    
    static private var maxCacheAgeInDays: Int {
        return 7
    }
    
    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calender.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }
}
