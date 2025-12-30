//
//  ClientNetworkProtocol.swift
//  TNMapSDKSample
//
//  Created by TechnoNext on 2/12/25.
//

import Foundation
import TNApiGetwaySDK

class ClientNetworkProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: "ClientHandled", in: request) != nil {
            return false
        }
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {

        guard let modifiedRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else {
            return
        }

        // Mark only CLIENT handled
        URLProtocol.setProperty(true, forKey: "ClientHandled", in: modifiedRequest)

        // Add client headers
        modifiedRequest.setValue("global-level-value-1", forHTTPHeaderField: "global-level-header-1")
        modifiedRequest.setValue("global-level-value-2", forHTTPHeaderField: "global-level-header-2")

        // 🔥 Important: DO NOT remove protocolClasses
        // This keeps FrameworkProtocol alive in the chain

        let config = URLSessionConfiguration.default
        config.protocolClasses = [
            ClientNetworkProtocol.self,
            FrameworkProtocol.self
        ]

        let session = URLSession(configuration: config)

        let task = session.dataTask(with: modifiedRequest as URLRequest) { data, response, error in

            // Log the request

            print("🔹 ClientNetworkProtocol: Headers -> \(modifiedRequest.allHTTPHeaderFields ?? [:])")

            if let response = response {
                print("🔹 ClientNetworkProtocol: Response -> \(response)")
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let data = data {
                if let str = String(data: data, encoding: .utf8) {
                    print("🔹 ClientNetworkProtocol: Response Data -> \(str)")
                }
                self.client?.urlProtocol(self, didLoad: data)
            }

            if let error = error {
                print("🔹 ClientNetworkProtocol: Error -> \(error.localizedDescription)")
                self.client?.urlProtocol(self, didFailWithError: error)
            }

            self.client?.urlProtocolDidFinishLoading(self)
        }
        task.resume()

    }

    override func stopLoading() {}
}
