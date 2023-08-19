import UIKit

class PlaybackViewController: UIViewController {
    
    var audioRecorderURL: URL

    private lazy var playbackOptionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playbackLineStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = .zero
        return stackView
    }()

    private lazy var playbackLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [slowAudioButton, fastAudioButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = .zero
        return stackView
    }()

    private lazy var slowAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "Slow"), for: .normal)
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()

    private lazy var fastAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "Fast"), for: .normal)
        return button
    }()

    private lazy var distanceLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [highAudioButton, lowAudioButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = .zero
        return stackView
    }()

    private lazy var highAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "HighPitch"), for: .normal)
        return button
    }()

    private lazy var lowAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "LowPitch"), for: .normal)
        return button
    }()

    private lazy var reflectionLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [echoAudioButton, reverbAudioButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = .zero
        return stackView
    }()

    private lazy var echoAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "Echo"), for: .normal)
        return button
    }()

    private lazy var reverbAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "Reverb"), for: .normal)
        return button
    }()

//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
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
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            playbackOptionsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            playbackOptionsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8 ),
            playbackOptionsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            playbackOptionsStackView.topAnchor.constraint(equalTo: view.topAnchor),
            playbackOptionsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8 ),
            playbackOptionsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            playbackOptionsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
