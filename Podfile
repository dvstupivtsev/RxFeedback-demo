platform :ios, '12.0'

def rx_pods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxRelay'
    pod 'RxBlocking'
    pod 'RxTest'
    pod 'RxFeedback'
end

target 'RxFeedbackDemo' do
  use_frameworks!
  
  rx_pods
  pod 'SnapKit'

  target 'RxFeedbackDemoTests' do
    inherit! :search_paths
  end

  target 'RxFeedbackDemoUITests' do
    inherit! :search_paths
  end

end
