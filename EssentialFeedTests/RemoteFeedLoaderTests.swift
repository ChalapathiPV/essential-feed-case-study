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
                
        XCTAssertNil(client.requestedURLs)
    }
    
    func test_load_requestsDataFromURL()  {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_loadTwice_requestsDataFromURLTwice()  {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load {capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HttpClientSpy) {
        let client = HttpClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    class HttpClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var completions = [(Error) -> Void]()
        
        func get(from url:URL, completion: @escaping (Error) -> Void) {
            completions.append(completion)
            requestedURLs.append(url)
        }
        
        func complete(with error: Error, at index: Int  = 0) {
            completions[index](error)
        }

    }

}
