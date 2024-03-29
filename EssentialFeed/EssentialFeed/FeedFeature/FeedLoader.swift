//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by PVC on 01/03/23.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

