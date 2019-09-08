//
//  Created by Stupivtsev Dmitriy on 08/09/2019.
//

import Foundation
import RxSwift
import RxCocoa
import RxTest

@testable import RxFeedbackDemo

class MainScreenIOMock: MainScreenIO {
    private let _scheduler: TestScheduler
    
    private(set) lazy var underlyingPlayerPitchText = _scheduler.createObserver(Optional<String>.self)
    private(set) lazy var playerPitchText = underlyingPlayerPitchText.asObserver()
    
    private(set) lazy var underlyingMachinePitchText = _scheduler.createObserver(Optional<String>.self)
    private(set) lazy var machinePitchText = underlyingMachinePitchText.asObserver()
    
    private(set) lazy var underlyingPitchButtonHidden = _scheduler.createObserver(Bool.self)
    private(set) lazy var pitchButtonHidden = underlyingPitchButtonHidden.asObserver()
    
    var underlyingPitchButtonTap: TestableObservable<Void>!
    var pitchButtonTap: Observable<Void> {
        return underlyingPitchButtonTap.asObservable()
    }
    
    init(scheduler: TestScheduler) {
        _scheduler = scheduler
    }
}
