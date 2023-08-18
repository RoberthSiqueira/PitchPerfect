import UIKit

class ViewController: UIViewController {
  
  private lazy var recordButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Record", for: .normal)
    button.backgroundColor = .red
    button.addTarget(self, action: #selector(recordAction), for: .touchUpInside)
    return button
  }()
  
  private lazy var recordingLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Tap to Record"
    return label
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
    
  }
  
  @objc private func recordAction() {
    print("record button was pressed")
  }
}

