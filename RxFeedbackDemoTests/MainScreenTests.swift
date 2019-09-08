//
//  Created by Stupivtsev Dmitriy on 08/09/2019.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking

@testable import RxFeedbackDemo

class MainScreenTests: XCTestCase {
    func testSystem() {
        let scheduler = TestScheduler(initialClock: 0)
        let bag = DisposeBag()
        let io = MainScreenIOMock(scheduler: scheduler)
        io.underlyingPitchButtonTap = scheduler.createColdObservable([.next(0, ())])
        let subject = MainScreen.make(scheduler: scheduler)(io)
        
        let observer = scheduler.createObserver(MainScreen.State.self)
        
        subject
            .bind(to: observer)
            .disposed(by: bag)
        
        scheduler.start()
        
        XCTAssertEqual(io.underlyingPlayerPitchText.events, [
            .next(1, "I have the 🏈"),
            .next(3, "I'm ready, hit me"),
            .next(5, "I have the 🏈")
        ])
        
        XCTAssertEqual(io.underlyingMachinePitchText.events, [
            .next(1, "I'm ready, hit me"),
            .next(3, "I have the 🏈"),
            .next(5, "I'm ready, hit me")
        ])
        
        XCTAssertEqual(io.underlyingPitchButtonHidden.events, [
            .next(1, false),
            .next(3, true),
            .next(5, false)
        ])
        
        XCTAssertEqual(observer.events, [
            .next(1, .playersPitch),
            .next(4, .machinesPitch),
            .next(6, .playersPitch),
        ])
    }
}
