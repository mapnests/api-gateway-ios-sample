//
//  TNMapSDKSampleApp.swift
//  TNMapSDKSample
//
//  Created by Kazi Md. Saidul on 30/4/25.
//

import SwiftUI

@main
struct TNMapSDKSampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationTitle("TNMapSDK Demos")
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Title
                Text("Choose a Demo")
                    .font(.title)
                    .padding(.top)

                // NavigationLink buttons
                NavigationLink(destination: APIURIProtocalDemoWrapper()) { // fixed typo
                    Text("API URI Protocol Demo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Add more buttons here if needed
            }
            .padding(.bottom)
        }
    }
}


struct APIURIProtocalDemoWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> APIURIProtocalDemo {
        return APIURIProtocalDemo()
    }

    func updateUIViewController(_ uiViewController: APIURIProtocalDemo, context: Context) {}
}
