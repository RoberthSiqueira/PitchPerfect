import UIKit

class PlaybackViewController: UIViewController {
    
    var audioRecorderURL: URL

    private lazy var playbackOptionsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = .zero
        return stackView
    }()

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
        view.backgroundColor = .white
        addViewHierarchy()
        setupConstraints()
    }

    private func addViewHierarchy() {
        view.addSubview(playbackOptionsStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playbackOptionsStackView.topAnchor.constraint(equalTo: view.topAnchor),
            playbackOptionsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8 ),
            playbackOptionsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            playbackOptionsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
