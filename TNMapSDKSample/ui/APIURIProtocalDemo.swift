import UIKit

class APIURIProtocalDemo: UIViewController {

    // MARK: - UI Elements
    private let logTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        tv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tv.layer.cornerRadius = 8
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private let callApiButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Call API", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = .systemBlue
        btn.tintColor = .white
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let clearLogButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Clear Log", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor = .systemRed
        btn.tintColor = .white
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(callApiButton)
        view.addSubview(clearLogButton)
        view.addSubview(logTextView)

        // Button actions
        callApiButton.addTarget(self, action: #selector(callApiButtonTapped), for: .touchUpInside)
        clearLogButton.addTarget(self, action: #selector(clearLogButtonTapped), for: .touchUpInside)

        // Layout
        NSLayoutConstraint.activate([
            callApiButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            callApiButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            callApiButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            callApiButton.heightAnchor.constraint(equalToConstant: 50),

            clearLogButton.topAnchor.constraint(equalTo: callApiButton.bottomAnchor, constant: 8),
            clearLogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clearLogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clearLogButton.heightAnchor.constraint(equalToConstant: 40),

            logTextView.topAnchor.constraint(equalTo: clearLogButton.bottomAnchor, constant: 16),
            logTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Button Actions
    @objc private func callApiButtonTapped() {
        let url = URL(string: "http://192.168.61.103:9080/load-test/api/auth-casbin-success-plugin-test")!
        let clientHeaders = [
            "Client-Header-Name1": "xxxxxx",
            "Client-Header-Name2": "yyyyyy"
        ]

        appendLog("➡️ Request URL: \(url.absoluteString)")
        appendLog("➡️ Headers: \(clientHeaders)")

        NetworkManager.shared.request(
            url: url,
            method: "GET",
            clientHeaders: clientHeaders
        ) { [weak self] data, response, error in
            if let error = error {
                self?.appendLog("❌ Error: \(error.localizedDescription)")
                return
            }

            if let response = response as? HTTPURLResponse {
                self?.appendLog("⬅️ Response Code: \(response.statusCode)")
                self?.appendLog("⬅️ Response Headers: \(response.allHeaderFields)")
            }

            if let data = data, let body = String(data: data, encoding: .utf8) {
                self?.appendLog("⬅️ Response Body:\n\(body)")
                self?.appendLog("-----------------")
            }
        }
    }

    @objc private func clearLogButtonTapped() {
        logTextView.text = ""
    }

    // MARK: - Logging Helper
    private func appendLog(_ text: String) {
        print(text)
        DispatchQueue.main.async {
            let newText = (self.logTextView.text ?? "") + text + "\n\n"
            self.logTextView.text = newText

            // Scroll to bottom
            let range = NSMakeRange(self.logTextView.text.count - 1, 0)
            self.logTextView.scrollRangeToVisible(range)
        }
    }
}
