import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presentationAdaptor = FeedLoaderPresentationAdapter(feedLoader:
                                                                    MainQueueDispatchDecorator(decoratee: feedLoader))
        
        let feedController = makeFeedViewController(            delegate: presentationAdaptor,
                                                                title: FeedPresenter.title)
        
        presentationAdaptor.presenter  = FeedPresenter(feedView: FeedViewAdapter(
            controller: feedController,
            imageLoader: imageLoader),
                                                       loadingView: WeakRefVirtualProxy(feedController))
        return feedController
    }
    
    private static func makeFeedViewController(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = title
        return feedController
    }
}
