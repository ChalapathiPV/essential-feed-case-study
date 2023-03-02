//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by PVC on 02/03/23.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
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
        let url = URL(string: "https://a-given-url.com")!
        let client  = HttpClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
                
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL()  {
        let url = URL(string: "https://a-given-url.com")!
        let client  = HttpClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
}
