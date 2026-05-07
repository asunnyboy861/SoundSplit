import SwiftUI

struct ContactSupportView: View {
    @State private var email = ""
    @State private var message = ""
    @State private var name = ""
    @State private var topic = "General"
    @State private var isSending = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    private let topics = ["General", "Bug Report", "Feature Request", "Subscription", "Other"]

    var body: some View {
        Form {
            Section {
                Picker("Topic", selection: $topic) {
                    ForEach(topics, id: \.self) { Text($0) }
                }

                TextField("Name (Optional)", text: $name)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            } header: {
                Text("YOUR INFO")
            }

            Section {
                TextEditor(text: $message)
                    .frame(minHeight: 100)
            } header: {
                Text("MESSAGE")
            }

            Section {
                Button {
                    sendMessage()
                } label: {
                    if isSending {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Submit")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(email.isEmpty || message.isEmpty || isSending)
            }
        }
        .navigationTitle("Contact Support")
        .alert("Feedback", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
    }

    private func sendMessage() {
        isSending = true
        let backendURL = "https://feedback-board.iocompile67692.workers.dev"

        guard let url = URL(string: backendURL) else {
            alertMessage = "Invalid server URL."
            showAlert = true
            isSending = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "topic": topic,
            "name": name,
            "email": email,
            "message": message,
            "app": "SoundSplit"
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                isSending = false
                if let error = error {
                    alertMessage = "Failed to send: \(error.localizedDescription)"
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    alertMessage = "Message sent successfully!"
                    email = ""
                    message = ""
                    name = ""
                    topic = "General"
                } else {
                    alertMessage = "Failed to send. Please try again."
                }
                showAlert = true
            }
        }.resume()
    }
}
