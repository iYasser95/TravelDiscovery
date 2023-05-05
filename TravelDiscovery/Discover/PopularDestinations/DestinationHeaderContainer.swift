//
//  DestinationHeaderContainer.swift
//  TravelDiscovery
//
//  Created by Apple on 01/05/2023.
//

import SwiftUI
import Kingfisher
struct DestinationHeaderContainer: UIViewControllerRepresentable {
    let imageNames: [String]
    typealias UIViewControllerType = UIViewController
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CustomPageController(images: imageNames)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No implementation needed
    }
}

class CustomPageController: UIPageViewController {
    var allControllers: [UIViewController] = []
    var imageNames: [String]
    init(images: [String]) {
        self.imageNames = images
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupControllers()
        dataSource = self
        delegate = self
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
    }

    private func setupControllers() {
        allControllers = imageNames.map({ imageName in
            let detailImage = KFImage(URL(string: imageName))
                .resizable()
                .scaledToFill()
            let hostingController = UIHostingController(rootView: detailImage)
            hostingController.view.clipsToBounds = true
            return hostingController
        })
        if let first = allControllers.first {
            setViewControllers([first],
                               direction: .forward,
                               animated: true)
        }
    }
}

// MARK: - Page Controller Delegate & DateSource
extension CustomPageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else { return nil }
        if index == 0 { return nil }
        return allControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else { return nil }
        if index == allControllers.count - 1 { return nil }
        return allControllers[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return allControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

struct DestinationHeaderContainer_Previews: PreviewProvider {
    static var previews: some View {
        let images = ["https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/7156c3c6-945e-4284-a796-915afdc158b5",
                      "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702",
                      "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531",
                      "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e"]
        DestinationHeaderContainer(imageNames: images)
            .frame(height: 250)
    }
}
