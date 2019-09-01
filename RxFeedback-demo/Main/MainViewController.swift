//
//  Created by Stupivtsev Dmitriy on 01/09/2019.
//

import UIKit
import RxSwift
import RxFeedback

final class MainViewController: BaseViewController<MainView> {
    private let _bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            scheduler: MainScheduler.instance,
            feedback: [
                makeUIBindings(),
                react(request: { $0.machinePitching }, effects: { _ in
                    Observable<Int>
                        .timer(.seconds(1), scheduler: MainScheduler.instance)
                        .map { _ in Event.throwToPlayer }
                })
            ]
        )
        .subscribe()
        .disposed(by: _bag)
    }
    
    private func makeUIBindings() -> System {
        return bind(self) { _self, state in
            return Bindings<Event>.init(
                subscriptions: [
                    state.map { $0.playersTitle }.bind(to: _self.customView.playerPitchLabel.rx.text),
                    state.map { $0.machinesTitle }.bind(to: _self.customView.machinePitchLabel.rx.text),
                    state.map { $0 == .machinesPitch }.bind(to: _self.customView.pitchButton.rx.isHidden)
                ],
                events: [
                    _self.customView.pitchButton.rx.tap.map { Event.throwToMachine }
                ]
            )
        }
    }
}

extension MainViewController {
    typealias System = (ObservableSchedulerContext<State>) -> Observable<Event>
    
    enum State {
        case playersPitch
        case machinesPitch
    }
    
    enum Event {
        case throwToMachine
        case throwToPlayer
    }
    
    fileprivate struct PitchRequest: Equatable {}
}

extension MainViewController.State {
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

    fileprivate var machinePitching: MainViewController.PitchRequest? {
        return self == .machinesPitch ? MainViewController.PitchRequest() : nil
    }
}
