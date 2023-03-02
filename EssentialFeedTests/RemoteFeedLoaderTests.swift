//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by PVC on 02/03/23.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTest {
    
    func test_init_doesnotRequestDataFromUrl() {
        let url = URL(string: "https://a-given-url.com")!
        let (_, client) = makeSUT(url: url)
                
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL()  {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HttpClientSpy) {
        let client = HttpClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    class HttpClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(from url:URL) {
            requestedURL = url
        }

    }

}
