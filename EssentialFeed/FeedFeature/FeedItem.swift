//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by PVC on 01/03/23.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
