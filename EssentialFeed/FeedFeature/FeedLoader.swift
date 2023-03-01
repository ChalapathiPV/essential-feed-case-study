//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by PVC on 01/03/23.
//

import Foundation

enum LoadFeedResult  {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

