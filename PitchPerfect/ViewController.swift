import UIKit

class ViewController: UIViewController {
  
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
  
  @objc private func recordAction() {
    recordingLabel.text = "Recording in Progress"
    recordButton.isEnabled = false
    stopRecordingButton.isEnabled = true
  }
  
  @objc private func stopRecordingAction() {
    recordingLabel.text = "Tap to Record"
    recordButton.isEnabled = true
    stopRecordingButton.isEnabled = false
  }
}

