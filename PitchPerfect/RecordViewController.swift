import AVFoundation
import UIKit

class RecordViewController: UIViewController {

    var audioRecorder: AVAudioRecorder?

    private var audioSession = AVAudioSession.sharedInstance()

    private lazy var recordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "Record"), for: .normal)
        button.addTarget(self, action: #selector(recordAction), for: .touchUpInside)
        return button
    }()

    private lazy var recordingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap to Record"
        return label
    }()

    private lazy var stopRecordingButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "Stop"), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(stopRecordingAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViewHierarchy()
        setupConstraints()
    }

    private func addViewHierarchy() {
        view.addSubview(recordButton)
        view.addSubview(recordingLabel)
        view.addSubview(stopRecordingButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            recordingLabel.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 8),
            recordingLabel.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            stopRecordingButton.topAnchor.constraint(equalTo: recordingLabel.bottomAnchor, constant: 8),
            stopRecordingButton.centerXAnchor.constraint(equalTo: recordingLabel.centerXAnchor),
            stopRecordingButton.widthAnchor.constraint(equalToConstant: 64),
            stopRecordingButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setRecordingState(_ recording: Bool) {
        recordingLabel.text = recording ? "Recording in Progress" : "Tap to Record"
        recordButton.isEnabled = !recording
        stopRecordingButton.isEnabled = recording
    }

    func goToPlaybackVC() {
        guard let url = audioRecorder?.url else { return }
        let playbackVC = PlaybackViewController(audioRecorderURL: url)
        navigationController?.pushViewController(playbackVC, animated: true)
    }

    @objc private func recordAction() {
        setRecordingState(true)

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath ?? String())

        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord,
                                      mode: AVAudioSession.Mode.default,
                                      options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        audioRecorder = try? AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        if audioRecorder?.prepareToRecord() == true {
            audioRecorder?.record()
        }

        // MARK: - Describing the code above

        // first of all, the UI state changes
        // then is created a .wav file called "recordedVoice" at a URL diretory on device. That URL at first a changed String joing two items paths separed with a bar
        // set the session category with some parameters
        // set audioRecoder with a 'url' and no 'settings' params
        // prepares the OS
        // record!
    }

    @objc private func stopRecordingAction() {
        setRecordingState(false)

        audioRecorder?.stop()
        try? audioSession.setActive(false)
    }
}
