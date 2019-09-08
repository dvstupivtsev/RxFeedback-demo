//
//  Created by Stupivtsev Dmitriy on 01/09/2019.
//

import Foundation

func setup<Type>(_ object: Type, block: (inout Type) -> Void) -> Type {
    var newObject = object
    block(&newObject)
    return newObject
}
