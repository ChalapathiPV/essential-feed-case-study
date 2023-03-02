//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by PVC on 02/03/23.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClinet {
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTest {
    
    func test_init_doesnotRequestDataFromUrl() {
        let client  = HTTPClinet()
        _ = RemoteFeedLoader()
                
        XCTAssertNil(client.requestedURL)
    }
}
