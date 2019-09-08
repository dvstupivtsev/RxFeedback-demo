//
//  Created by Stupivtsev Dmitriy on 01/09/2019.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController<MainView> {
    private let _viewModel: MainScreen.ViewModel
    private let _bag = DisposeBag()
    
    init(viewModel: @escaping MainScreen.ViewModel) {
        _viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _viewModel(self)
            .subscribe()
            .disposed(by: _bag)
    }
}

extension MainViewController: MainScreenIO {
    var playerPitchText: AnyObserver<String?> {
        return customView.playerPitchLabel.rx.text.asObserver()
    }
    
    var machinePitchText: AnyObserver<String?> {
        return customView.machinePitchLabel.rx.text.asObserver()
    }
    
    var pitchButtonHidden: AnyObserver<Bool> {
        return customView.pitchButton.rx.isHidden.asObserver()
    }
    
    var pitchButtonTap: Observable<Void> {
        return customView.pitchButton.rx.tap.asObservable()
    }
}
