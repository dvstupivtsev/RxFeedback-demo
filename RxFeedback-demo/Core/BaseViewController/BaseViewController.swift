//
//  Created by Stupivtsev Dmitriy on 01/09/2019.
//

import UIKit

class BaseViewController<View: BaseView>: UIViewController {
    private(set) lazy var customView = View(frame: .zero)
    
    override func loadView() {
        view = customView
    }
}
