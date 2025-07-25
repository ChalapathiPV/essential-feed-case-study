//
//  FeedViewControllerTests+Assertions.swift
//  EssentialFeediOSTests
//

import XCTest
import EssentialFeed
import EssentialFeediOS

extension FeedViewControllerTests {
    func assertThat(_ sut: FeedViewController, isRendering feed: [FeedImage], file: StaticString = #file , line: UInt = #line) {
        guard (sut.numberOfRenderedFeedImageViews() == feed.count) else {
            XCTFail("Expected \(feed.count) images, got \(sut.numberOfRenderedFeedImageViews()) instead", file: file, line: line)
            return
        }

        feed.enumerated().forEach { index, image in
            assertThat(sut, hasViewConfiguredFor: image, at: index, file:file, line: line)
        }

    }

    func assertThat(_ sut: FeedViewController, hasViewConfiguredFor image: FeedImage, at index: Int, file: StaticString = #file, line: UInt = #line) {
        let view = sut.feedImageView(at: index)
        
        guard let cell = view as? FeedImageCell else {
            return XCTFail("Expected \(FeedImageCell.self) instance , got \(String(describing: view)) instead", file: file, line: line)
        }
        
        let shouldLocationBeVisible = (image.location != nil)
        XCTAssertEqual(cell.isShowingLocation, shouldLocationBeVisible, "Expected 'isShowingLocation' to be \(shouldLocationBeVisible) for the imageview at \(index)", file: file, line: line)
        XCTAssertEqual(cell.locationText, image.location, "Expected location to be \(String(describing: image.location)) for the image view at index\(index)", file: file, line: line)
        XCTAssertEqual(cell.descriptionText, image.description, "Expected description tex to be \(String(describing: image.description)) for the image view at \(index)", file: file, line: line)
    }
}
