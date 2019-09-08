//
//  Created by Stupivtsev Dmitriy on 03/09/2019.
//

import Foundation
import RxSwift

protocol MainScreenIO {
    var playerPitchText: AnyObserver<String?> { get }
    var machinePitchText: AnyObserver<String?> { get }
    var pitchButtonHidden: AnyObserver<Bool> { get }
    var pitchButtonTap: Observable<Void> { get }
}
