import AVFoundation
import UIKit

class PlaybackViewController: UIViewController {
    
    var audioRecorderURL: URL

    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    private lazy var playbackOptionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [speedLineStackView, distanceLineStackView, reflectionLineStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = .zero
        return stackView
    }()

    private lazy var speedLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [slowAudioButton, fastAudioButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = .zero
        return stackView
    }()

    lazy var slowAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "Slow"), for: .normal)
        button.addTarget(self, action: #selector(playSoundsAction), for: .touchUpInside)
        return button
    }()

    lazy var fastAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "Fast"), for: .normal)
        button.addTarget(self, action: #selector(playSoundsAction), for: .touchUpInside)
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

    lazy var highAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "HighPitch"), for: .normal)
        button.addTarget(self, action: #selector(playSoundsAction), for: .touchUpInside)
        return button
    }()

    lazy var lowAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "LowPitch"), for: .normal)
        button.addTarget(self, action: #selector(playSoundsAction), for: .touchUpInside)
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

    lazy var echoAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "Echo"), for: .normal)
        button.addTarget(self, action: #selector(playSoundsAction), for: .touchUpInside)
        return button
    }()

    lazy var reverbAudioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "Reverb"), for: .normal)
        button.addTarget(self, action: #selector(playSoundsAction), for: .touchUpInside)
        return button
    }()

    lazy var stopButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "Stop"), for: .normal)
        button.addTarget(self, action: #selector(stopSoundsAction), for: .touchUpInside)
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
        setupAudio()
        addViewHierarchy()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    private func addViewHierarchy() {
        view.addSubview(playbackOptionsStackView)
        view.addSubview(stopButton)
    }

    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            playbackOptionsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            playbackOptionsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8 ),
            playbackOptionsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 64),
            stopButton.heightAnchor.constraint(equalToConstant: 64),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: playbackOptionsStackView.bottomAnchor, constant: 8),
            stopButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    @objc private func playSoundsAction(_ sender: UIButton) {
        if sender == slowAudioButton {
            playSound(rate: 0.5)
        } else if sender == fastAudioButton {
            playSound(rate: 1.5)
        } else if sender == highAudioButton {
            playSound(pitch: 1000)
        } else if sender == lowAudioButton {
            playSound(pitch: -1000)
        } else if sender == echoAudioButton {
            playSound(echo: true)
        } else if sender == reverbAudioButton {
            playSound(reverb: true)
        } else {
            return
        }

        configureUI(.playing)
    }

    @objc private func stopSoundsAction() {
        stopAudio()
    }
}
