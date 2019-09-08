//
//  Created by Stupivtsev Dmitriy on 03/09/2019.
//

import Foundation
import RxSwift
import RxCocoa
import RxFeedback

enum MainScreen {
    typealias ViewModel = (_ io: MainScreenIO) -> Observable<State>
    
    static func make(scheduler: SchedulerType = MainScheduler.instance) -> ViewModel {
        return { io in
            Observable.system(
                initialState: State.playersPitch,
                reduce: { (state: State, event: Event) -> State in
                    switch event {
                    case .throwToMachine:
                        return .machinesPitch
                    case .throwToPlayer:
                        return .playersPitch
                    }
                },
                scheduler: scheduler,
                feedback: [
                    bind { state in
                        return Bindings<Event>(
                            subscriptions: [
                                state.map { $0.playersTitle }.bind(to: io.playerPitchText),
                                state.map { $0.machinesTitle }.bind(to: io.machinePitchText),
                                state.map { $0 == .machinesPitch }.bind(to: io.pitchButtonHidden)
                            ],
                            events: [
                                io.pitchButtonTap.map { Event.throwToMachine }
                            ]
                        )
                    },
                    react(request: { $0.machinePitching }, effects: { _ in
                        Observable<Int>
                            .timer(.seconds(1), scheduler: scheduler)
                            .map { _ in Event.throwToPlayer }
                    })
                ]
            )
        }
    }
}

extension MainScreen {
    private typealias System = (ObservableSchedulerContext<State>) -> Observable<Event>
    
    enum State {
        case playersPitch
        case machinesPitch
        
        fileprivate struct PitchRequest: Equatable {}
        
        var playersTitle: String? {
            switch self {
            case .playersPitch:
                return "I have the 🏈"
            case .machinesPitch:
                return "I'm ready, hit me"
            }
        }
        
        var machinesTitle: String? {
            switch self {
            case .playersPitch:
                return "I'm ready, hit me"
            case .machinesPitch:
                return "I have the 🏈"
            }
        }

        fileprivate var machinePitching: PitchRequest? {
            return self == .machinesPitch ? PitchRequest() : nil
        }
    }
    
    private enum Event {
        case throwToMachine
        case throwToPlayer
    }
}
