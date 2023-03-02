//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by PVC on 02/03/23.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://a-url.com")!)
    }
    
}

protocol HTTPClient {
    func get(from url:URL)
}

class HttpClientSpy: HTTPClient {
    func get(from url:URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?

}

class RemoteFeedLoaderTests: XCTest {
    
    func test_init_doesnotRequestDataFromUrl() {
        let client  = HttpClientSpy()
        _ = RemoteFeedLoader(client: client)
                
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL()  {
        let client  = HttpClientSpy()
        let sut = RemoteFeedLoader(client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
