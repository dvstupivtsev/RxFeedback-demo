//
//  Created by Stupivtsev Dmitriy on 01/09/2019.
//

import UIKit

struct WindowRouter {
    func setup(window: UIWindow) {
        window.rootViewController = MainViewController()
        window.makeKeyAndVisible()
    }
}
