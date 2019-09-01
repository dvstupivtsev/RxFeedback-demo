//
//  Created by Stupivtsev Dmitriy on 01/09/2019.
//

import UIKit

class BaseView: UIView {
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() { }
}
