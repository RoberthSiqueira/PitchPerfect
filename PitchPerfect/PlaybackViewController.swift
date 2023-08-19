import UIKit

class PlaybackViewController: UIViewController {
    
    var audioRecorderURL: URL

    init(audioRecorderURL: URL) {
        self.audioRecorderURL = audioRecorderURL
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
