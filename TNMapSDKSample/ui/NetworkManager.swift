//
//  NetworkManager.swift
//  TNMapSDKSample
//
//  Created by TechnoNext on 2/12/25.
//

import Foundation
import TNApiGetwaySDK



public class NetworkManager {

    public static let shared = NetworkManager()

    private init() {}

    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [ClientNetworkProtocol.self] // Inject framework headers
        return URLSession(configuration: config)
    }()

    public func request(
        url: URL,
        method: String = "GET",
        clientHeaders: [String: String]? = nil,
        parameters: [String: Any]? = nil,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        var requestURL = url

        // GET -> query parameters
        if method.uppercased() == "GET", let params = parameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            if let finalURL = components.url {
                requestURL = finalURL
            }
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.uppercased()

        // Add client headers first
        if let clientHeaders = clientHeaders {
            for (key, value) in clientHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        // POST/PUT -> JSON body
        if method.uppercased() != "GET", let params = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        // Send request using session with FrameworkProtocol
        let task = session.dataTask(with: request) { data, response, error in
//            print("Request URL: \(request.url?.absoluteString ?? "")")
//            print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status: \(httpResponse.statusCode)")
            }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            completion(data, response, error)
        }
        task.resume()
    }
}
