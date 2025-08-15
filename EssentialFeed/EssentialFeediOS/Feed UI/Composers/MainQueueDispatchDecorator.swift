//
//  MainQueueDispatchDecorator.swift
//  EssentialFeediOS
//
//

import Foundation
import EssentialFeed

final class MainQueueDispatchDecorator<T> {
    private let decorater: T
    
    init(decoratee: T) {
        self.decorater = decoratee
    }

    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        return completion()
    }
    
}

extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decorater.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: FeedImageDataLoader where T == FeedImageDataLoader {
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decorater.loadImageData(from: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

