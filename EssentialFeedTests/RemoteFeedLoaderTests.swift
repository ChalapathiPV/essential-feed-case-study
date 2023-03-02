//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by PVC on 02/03/23.
//

import XCTest

class RemoteFeedLoader {
    
    func load() {
        HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
    }
    
}

class HTTPClient {
    static var shared = HTTPClient()
    
    func get(from url:URL) {}
}

class HttpClientSpy: HTTPClient {
    override func get(from url:URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?

}

class RemoteFeedLoaderTests: XCTest {
    
    func test_init_doesnotRequestDataFromUrl() {
        let client  = HttpClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
                
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL()  {
        let client  = HttpClientSpy()
        HTTPClient.shared = client
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
