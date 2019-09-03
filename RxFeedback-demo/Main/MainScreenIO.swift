//
//  Created by Stupivtsev Dmitriy on 03/09/2019.
//

import Foundation
import RxCocoa

protocol MainScreenIO {
    var playerPitchText: Binder<String?> { get }
    var machinePitchText: Binder<String?> { get }
    var pitchButtonHidden: Binder<Bool> { get }
    var pitchButtonTap: ControlEvent<Void> { get }
}
