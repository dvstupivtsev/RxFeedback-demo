//
//  Created by Stupivtsev Dmitriy on 01/09/2019.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    private let myPitchLabel = setup(UILabel()) {
        $0.textColor = .white
    }
    
    private let machinePitchLabel = setup(UILabel()) {
        $0.textColor = .white
    }
    
    private let pitchButton = setup(UIButton(type: .system)) {
        $0.setTitle("Make Pitch", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    
    private let topFieldBackgroundView = setup(UIView()) {
        $0.backgroundColor = .red
    }
    
    private let bottomFieldBackgroundView = setup(UIView()) {
        $0.backgroundColor = .blue
    }
    
    override func commonInit() {
        addSubviews(
            topFieldBackgroundView,
            bottomFieldBackgroundView
        )
        
        topFieldBackgroundView.addSubviews(
            myPitchLabel,
            pitchButton
        )
        
        bottomFieldBackgroundView.addSubview(machinePitchLabel)
        
        topFieldBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        bottomFieldBackgroundView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(topFieldBackgroundView.snp.bottom)
            make.height.equalTo(topFieldBackgroundView)
        }
        
        machinePitchLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        myPitchLabel.snp.makeConstraints { make in
            make.bottom.equalTo(topFieldBackgroundView.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        pitchButton.snp.makeConstraints { make in
            make.top.equalTo(topFieldBackgroundView.snp.centerY)
            make.centerX.equalToSuperview()
        }
    }
}
